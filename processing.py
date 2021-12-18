import logging
import sys
from typing import List
import pandas as pd

from sqlalchemy import desc

from constants import mandatory_sheets
from db import session, CofkCollectStatus, CofkCollectAuthorOfWork, CofkCollectAddresseeOfWork, CofkCollectUpload, \
    CofkCollectWork, CofkCollectPersonMentionedInWork, CofkCollectLocation, CofkCollectPerson, \
    CofkCollectLanguageOfWork, CofkCollectWorkResource

# CofkCollectStatus needs to be populated with some values
if CofkCollectStatus.is_empty():
    session.add(CofkCollectStatus(status_id=1, status_desc="Awaiting review"))
    session.add(CofkCollectStatus(status_id=2, status_desc="Partly reviewed"))
    session.add(CofkCollectStatus(status_id=3, status_desc="Review complete", editable=0))
    session.add(CofkCollectStatus(status_id=4, status_desc="Accepted and saved into main database", editable=0))
    session.add(CofkCollectStatus(status_id=5, status_desc="Rejected", editable=0))

    session.commit()


class ExcelFileProcess:

    def __init__(self, logger: logging.Logger, filename: str):
        """
        non_work_data will contain any raw data about:
        1. origin location
        2. destination location
        3. people mentioned
        4. languages used
        5. resources
        6. authors
        7. addressees
        :param logger:
        :param filename:
        """
        self.logger = logger
        self.filename = filename
        self.wb = self.load_file(filename)
        self.iwork_id = None
        self.work_data = {}
        self.non_work_data = {}

        self.check_sheets()

        self.upload = self.create_upload()

    def load_file(self, filename: str) -> pd.DataFrame:
        """
        Setting sheet_name to None returns a dict with sheet name as key and data frame as value
        Occasionally additional data is included that we cannot parse, so we ignore "Unnamed:" columns
        Supports xls, xlsx, xlsm, xlsb, odf, ods and odt file extensions read from a local filesystem or URL.
        https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_excel.html
        :param filename:
        :return:
        """
        try:
            wb = pd.read_excel(filename, sheet_name=None,
                               usecols=lambda c: not c.startswith('Unnamed:'))
            self.logger.info("Successfully read file: {}".format(filename))
        except FileNotFoundError as fnfe:
            self.logger.error("File {} not found".format(filename))
            sys.exit(1)
        return wb

    def check_sheets(self):
        # Verify all required sheets are present
        if len(mandatory_sheets - self.wb.keys()) > 0:
            self.logger.error("Missing sheet/s: {}".format(",".join(list(mandatory_sheets - self.wb.keys()))))
            sys.exit(1)
        self.logger.debug("All {} sheets verified".format(len(mandatory_sheets)))

    def preprocess_languages(self):
        work_languages = []

        if self.non_work_data['hashebrew']:
            work_languages.append("heb")

        if self.non_work_data['hasarabic']:
            work_languages.append("ara")

        if self.non_work_data['hasgreek']:
            work_languages.append("ell")

        if self.non_work_data['haslatin']:
            work_languages.append("lat")

        if len(work_languages):
            self.process_languages(work_languages)

    def process_authors(self, author_ids, author_names):
        author_ids = str(self.non_work_data[author_ids])
        author_names = str(self.non_work_data[author_names])

        authors = self.process_people(author_ids, author_names)

        author_id = session.query(CofkCollectAuthorOfWork.author_id) \
            .order_by(desc(CofkCollectAuthorOfWork.author_id)).first()

        if not author_id:
            author_id = 1
        else:
            author_id = author_id[0]

        for p in authors:
            author = CofkCollectAuthorOfWork(
                author_id=author_id,
                upload_id=self.upload.upload_id,
                iwork_id=self.iwork_id,
                iperson_id=p)
            author_id = author_id + 1

            session.add(author)
        session.commit()

    def process_addressees(self, addressee_ids, addressee_names):
        addressee_ids = str(self.non_work_data[addressee_ids])
        addressee_names = str(self.non_work_data[addressee_names])

        addressees = self.process_people(addressee_ids, addressee_names)

        addressee_id = session.query(CofkCollectAddresseeOfWork.addressee_id) \
            .order_by(desc(CofkCollectAddresseeOfWork.addressee_id)).first()

        if not addressee_id:
            addressee_id = 1
        else:
            addressee_id = addressee_id[0]

        for p in addressees:
            addressee = CofkCollectAddresseeOfWork(
                addressee_id=addressee_id,
                upload_id=self.upload.upload_id,
                iwork_id=self.iwork_id,
                iperson_id=p)
            addressee_id = addressee_id + 1

            session.add(addressee)
        session.commit()

    def create_upload(self) -> CofkCollectUpload:
        """
        Utility function to create an upload.
        Parameters hard-coded in original version, see short-link to source code:
        https://bit.ly/3dXwhEt
        upload_description could also be provided, but it is a re-parsed timestamp
        of creation time.
        :return:
        """
        upl = CofkCollectUpload(upload_username='cofkcottage',
                                uploader_email='anusha@cottagelabs.com')
        session.add(upl)
        session.commit()

        self.logger.info("Upload {} created".format(upl.upload_id))

        return upl

    def preprocess_data(self):
        # Isolating data relevant to a work
        non_work_keys = list(set(self.work_data.keys()) - set([c for c in CofkCollectWork.__dict__.keys()]))

        # Removing non work data so that variable work_data_raw can be used to pass parameters
        # to create a CofkCollectWork object
        for m in non_work_keys:
            self.non_work_data[m] = self.work_data[m]
            del self.work_data[m]

    def process_work(self, work_data):
        """
        This method processes one row of data from the Excel sheet.

        :param work_data:
        :return:
        """
        self.work_data = work_data
        self.work_data['upload_id'] = self.upload.upload_id
        self.iwork_id = work_data['iwork_id']

        self.logger.info("Processing work, iwork_id #{}, upload_id #{}".format(
            self.iwork_id, self.upload.upload_id))

        self.preprocess_data()

        # Origin location needs to be processed before work is created
        # Is it possible that a work has more than one origin?
        try:
            self.work_data['origin_id'] = self.process_location(
                loc_id=self.work_data['origin_id'],
                name=self.non_work_data['origin_name'])
        except ValueError as ve:
            self.logger.error("Origin id '{}' is not a number".format(work_data['origin_id']))
            sys.exit(1)

        # Destination location needs to be processed before work is created
        # Is it possible that a work has more than one destination?
        work_data['destination_id'] = self.process_location(
            loc_id=self.work_data['destination_id'],
            name=self.non_work_data['destination_name'])

        # Creating the work itself
        work = CofkCollectWork(**work_data)
        session.add(work)
        session.commit()

        # Processing people mentioned in work
        self.process_mentions('emlo_mention_id', 'mention_id')

        # Processing languages used in work
        self.preprocess_languages()

        # Processing resources in work
        if 'resource_name' in self.non_work_data or 'resource_url' in self.non_work_data:
            self.process_resource()

        self.process_authors('author_ids', 'author_names')

        self.process_addressees('addressee_ids', 'addressee_names')

    def process_mentions(self, emlo_mention_ids: str, mention_ids: str):
        emlo_mention_ids = str(self.non_work_data[emlo_mention_ids])
        mention_ids = str(self.non_work_data[mention_ids])

        # Before mentions can be registered the people mentioned need
        # to be created
        people_mentioned = self.process_people(emlo_mention_ids, mention_ids)

        mention_id = session.query(CofkCollectPersonMentionedInWork.mention_id) \
            .order_by(desc(CofkCollectPersonMentionedInWork.mention_id)).first()

        if not mention_id:
            mention_id = 1
        else:
            mention_id = mention_id[0]

        for p in people_mentioned:
            person_mention = CofkCollectPersonMentionedInWork(
                mention_id=mention_id,
                upload_id=self.upload.upload_id,
                iwork_id=self.iwork_id,
                iperson_id=p)
            mention_id = mention_id + 1

            session.add(person_mention)
        session.commit()

    def process_location(self, loc_id, name) -> int:
        """
        Method that checks if a location specific to the location id and upload exists,
        if so it returns the id provided id if not a new location is created incrementing
        the highest location id by one.
        :param loc_id:
        :param name:
        :return:
        """

        loc_id = int(loc_id)

        location_id = session.query(CofkCollectLocation.location_id) \
            .filter_by(location_id=loc_id, upload_id=self.upload.upload_id).first()

        if location_id is None:
            location_id = session.query(CofkCollectLocation.location_id) \
                .order_by(desc(CofkCollectLocation.location_id)).first()

            if not location_id:
                location_id = 1
            else:
                location_id = location_id[0] + 1

            loc = CofkCollectLocation(upload_id=self.upload.upload_id,
                                      location_id=location_id,
                                      location_name=name)

            session.add(loc)
            session.commit()

        return location_id

    def process_people(self, ids: str, names: str) -> List[int]:
        """
        This method assumes that the data holds correct information on persons.
        That means that if the id and name specific to the current upload do not exist,
        they are created.
        :param ids:
        :param names:
        :return:
        """
        people = []
        for person in zip(ids.split(';'), names.split(';')):
            # NOTE THIS IS FILTERING BY PERSON_ID AND UPLOAD_ID SO
            # THERE IS BOUND TO BE MASSIVE DUPLICATION IN THIS TABLE
            person_id = session.query(CofkCollectPerson.iperson_id) \
                .filter_by(iperson_id=person[0],
                           upload_id=self.upload.upload_id).first()

            if person_id is None:
                # Person does not exist, so we need to create it
                new_person = CofkCollectPerson(
                    upload_id=self.upload.upload_id,
                    iperson_id=person[0],
                    primary_name=person[1])
                session.add(new_person)
                session.commit()

                people.append(new_person.iperson_id)
            else:
                people.append(person_id[0])

        return people

    def process_languages(self, has_language: List[str]):
        language_id = session.query(CofkCollectLanguageOfWork.language_of_work_id) \
            .order_by(desc(CofkCollectLanguageOfWork.language_of_work_id)).first()

        if not language_id:
            language_id = 1
        else:
            language_id = language_id[0]

        for language in has_language:
            lang = CofkCollectLanguageOfWork(
                language_of_work_id=language_id,
                upload_id=self.upload.upload_id,
                iwork_id=self.iwork_id,
                language_code=language)
            language_id = language_id + 1

            session.add(lang)
        session.commit()

    def process_resource(self):
        resource_name = self.non_work_data['resource_name'] if 'resource_name' in self.non_work_data else None
        resource_url = self.non_work_data['resource_url'] if 'resource_url' in self.non_work_data else None
        resource_details = self.non_work_data['resource_details'] if 'resource_details' in self.non_work_data else None

        resource_id = session.query(CofkCollectWorkResource.resource_id) \
            .order_by(desc(CofkCollectWorkResource.resource_id)).first()

        if not resource_id:
            resource_id = 1
        else:
            resource_id = resource_id[0] + 1

        resource = CofkCollectWorkResource(
            upload_id=self.upload.upload_id,
            iwork_id=self.iwork_id,
            resource_id=resource_id,
            resource_name=resource_name,
            resource_url=resource_url,
            resource_details=resource_details)
        session.add(resource)
        session.commit()
