from datetime import datetime
import logging
from typing import List
import pandas as pd

from sqlalchemy import desc

from constants import mandatory_sheets
from db import session, CofkCollectStatus, CofkCollectAuthorOfWork, CofkCollectAddresseeOfWork, CofkCollectUpload, \
    CofkCollectWork, CofkCollectPersonMentionedInWork, CofkCollectLocation, CofkCollectPerson, \
    CofkCollectLanguageOfWork, CofkCollectWorkResource, CofkCollectInstitution, CofkCollectManifestation

from validation import validate_work, validate_manifestation

# CofkCollectStatus needs to be populated with some values
# necessary if developing in a vanilla system
if CofkCollectStatus.is_empty():
    session.add(CofkCollectStatus(status_id=1, status_desc="Awaiting review"))
    session.add(CofkCollectStatus(status_id=2, status_desc="Partly reviewed"))
    session.add(CofkCollectStatus(status_id=3, status_desc="Review complete", editable=0))
    session.add(CofkCollectStatus(status_id=4, status_desc="Accepted and saved into main database", editable=0))
    session.add(CofkCollectStatus(status_id=5, status_desc="Rejected", editable=0))

    session.commit()


class CofkRepositories:  #

    def __init__(self, logger: logging.Logger, upload_id: str, sheet_data: pd.DataFrame, limit=None):
        self.logger = logger
        self.upload_id = upload_id

        self.__institution_id = None
        self.sheet = sheet_data
        self.__repository_data = {}
        limit = limit if limit else len(self.sheet.index)
        self.ids = []

        # Process each row in turn, using a dict comprehension to filter out empty values
        for i in range(1, limit):
            self.process_repository({k: v for k, v in self.sheet.iloc[i].to_dict().items() if v is not None})

    def process_repository(self, repository_data):
        self.__repository_data = repository_data
        self.__repository_data['upload_id'] = self.upload_id
        self.__institution_id = repository_data['institution_id']

        self.logger.info("Processing repository, institution_id #{}, upload_id #{}".format(
            self.__institution_id, self.upload_id))

        if not self.already_exists():
            # Name, city and country are required
            repository = CofkCollectInstitution(**self.__repository_data)
            session.add(repository)
            session.commit()
            self.ids.append(self.__institution_id)
            self.logger.info("Repository created.")

    def already_exists(self) -> bool:
        return session.query(CofkCollectInstitution.institution_id) \
                   .filter_by(institution_id=self.__institution_id, upload_id=self.upload_id).first() is not None


class CofkLocations:  #

    def __init__(self, logger: logging.Logger, upload_id: str, sheet_data: pd.DataFrame, limit=None):
        self.logger = logger
        self.upload_id = upload_id

        self.__location_id = None
        self.sheet = sheet_data
        self.__location_data = {}
        limit = limit if limit else len(self.sheet.index)
        self.ids = []

        # Process each row in turn, using a dict comprehension to filter out empty values
        for i in range(1, limit):
            self.process_location({k: v for k, v in self.sheet.iloc[i].to_dict().items() if v is not None})

    def process_location(self, repository_data):
        self.__location_data = repository_data
        self.__location_data['upload_id'] = self.upload_id
        self.__location_id = repository_data['location_id']

        self.logger.info("Processing location, location_id #{}, upload_id #{}".format(
            self.__location_id, self.upload_id))

        if not self.already_exists():
            # Name, city and country are required
            location = CofkCollectLocation(**self.__location_data)
            session.add(location)
            session.commit()
            self.ids.append(self.__location_id)
            self.logger.info("Location created.")

    def already_exists(self) -> bool:
        return session.query(CofkCollectLocation.location_id) \
                   .filter_by(location_id=self.__location_id, upload_id=self.upload_id).first() is not None


class CofkPeople:

    def __init__(self, logger: logging.Logger, upload_id: str, sheet_data: pd.DataFrame, limit=None):
        self.logger = logger
        self.upload_id = upload_id

        self.__person_id = None
        self.sheet = sheet_data
        self.__person_data = {}
        limit = limit if limit else len(self.sheet.index)
        self.ids = []

        # Process each row in turn, using a dict comprehension to filter out empty values
        for i in range(1, limit):
            self.process_people({k: v for k, v in self.sheet.iloc[i].to_dict().items() if v is not None})

    def process_people(self, person_data):
        self.__person_data = person_data
        self.__person_data['upload_id'] = self.upload_id
        self.__person_id = str(person_data['iperson_id'])

        self.logger.info("Processing person, iperson_id #{}, upload_id #{}".format(
            self.__person_id, self.upload_id))

        if not self.already_exists():
            person = CofkCollectPerson(**self.__person_data)
            session.add(person)
            session.commit()
            self.ids.append(self.__person_id)
            self.logger.info("Person created.")

    def already_exists(self) -> bool:
        return session.query(CofkCollectPerson.person_id) \
                   .filter_by(person_id=self.__person_id, upload_id=self.upload_id).first() is not None


class CofkManifestations:

    def __init__(self, logger: logging.Logger, upload_id: str, sheet_data: pd.DataFrame, limit=None):
        self.logger = logger
        self.upload_id = upload_id

        self.__manifestation_id = None
        self.sheet = sheet_data
        self.__non_manifestation_data = {}
        self.__manifestation_data = {}
        limit = limit if limit else len(self.sheet.index)
        self.ids = []

        # Process each row in turn, using a dict comprehension to filter out empty values
        for i in range(1, limit):
            self.process_manifestation({k: v for k, v in self.sheet.iloc[i].to_dict().items() if v is not None})

    def preprocess_data(self):
        self.__manifestation_data = {k.replace(' ', '_'): v for k, v in self.__manifestation_data.items()}

        # Isolating data relevant to a work
        non_work_keys = list(
            set(self.__manifestation_data.keys()) - set([c for c in CofkCollectManifestation.__dict__.keys()]))

        # Removing non work data so that variable work_data_raw can be used to pass parameters
        # to create a CofkCollectWork object
        for m in non_work_keys:
            self.__non_manifestation_data[m] = self.__manifestation_data[m]
            del self.__manifestation_data[m]

    def process_manifestation(self, manifestation_data):
        self.__manifestation_data = manifestation_data
        self.preprocess_data()

        self.__manifestation_data['upload_id'] = self.upload_id
        self.__manifestation_id = str(manifestation_data['manifestation_id'])

        self.logger.info("Processing manifestation, manifestation_id #{}, upload_id #{}".format(
            self.__manifestation_id, self.upload_id))

        if not self.already_exists():
            person = CofkCollectManifestation(**self.__manifestation_data)
            session.add(person)
            session.commit()
            self.ids.append(self.__manifestation_id)
            self.logger.info("Manifestation created.")

    def already_exists(self) -> bool:
        return session.query(CofkCollectManifestation.manifestation_id) \
                   .filter_by(manifestation_id=self.__manifestation_id, upload_id=self.upload_id).first() is not None


class CofkWork:

    def __init__(self, logger: logging.Logger, upload_id: str, sheet_data: pd.DataFrame,
                limit=None):
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
        :param upload_id:
        """
        self.logger = logger
        self.upload_id = upload_id

        self.iwork_id = None
        self.sheet = sheet_data
        self.work_data = {}
        self.non_work_data = {}
        self.ids = []

        limit = limit if limit else len(self.sheet.index)

        # Process each row in turn, using a dict comprehension to filter out empty values
        for i in range(1, limit):
            self.process_work({k: v for k, v in self.sheet.iloc[i].to_dict().items() if v is not None})

    def preprocess_languages(self):
        work_languages = []

        if 'hashebrew' in self.non_work_data:
            work_languages.append("heb")

        if 'hasarabic' in self.non_work_data:
            work_languages.append("ara")

        if 'hasgreek' in self.non_work_data:
            work_languages.append("ell")

        if 'haslatin' in self.non_work_data:
            work_languages.append("lat")

        if len(work_languages):
            self.logger.info("Foreign language in iwork_id #{}, upload_id #{}".format(
                self.iwork_id, self.upload_id))
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
                upload_id=self.upload_id,
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
                upload_id=self.upload_id,
                iwork_id=self.iwork_id,
                iperson_id=p)
            addressee_id = addressee_id + 1

            session.add(addressee)
        session.commit()

    def preprocess_data(self):
        # Isolating data relevant to a work
        non_work_keys = list(set(self.work_data.keys()) - set([c for c in CofkCollectWork.__dict__.keys()]))

        # Removing non-work data so that variable work_data_raw can be used to pass parameters
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

        self.work_data['upload_id'] = self.upload_id
        self.iwork_id = work_data['iwork_id']

        self.logger.info("Processing work, iwork_id #{}, upload_id #{}".format(
            self.iwork_id, self.upload_id))

        self.preprocess_data()

        # Origin location needs to be processed before work is created
        # Is it possible that a work has more than one origin?
        if 'origin_id' in self.work_data:
            self.work_data['origin_id'] = self.process_location(
                loc_id=self.work_data['origin_id'],
                name=self.non_work_data['origin_name'])

        # Destination location needs to be processed before work is created
        # Is it possible that a work has more than one destination?
        if 'destination_id' in self.work_data:
            work_data['destination_id'] = self.process_location(
                loc_id=self.work_data['destination_id'],
                name=self.non_work_data['destination_name'])

        # Creating the work itself
        work = CofkCollectWork(**work_data)
        session.add(work)
        session.commit()
        self.ids.append(self.iwork_id)

        self.logger.info("Work created iwork_id #{}, upload_id #{}".format(
            self.iwork_id, self.upload_id))

        # Processing people mentioned in work
        if 'emlo_mention_id' in self.work_data and 'mention_id' in self.work_data:
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

        self.logger.info("Processing people mentioned , iwork_id #{}, upload_id #{}".format(
            self.iwork_id, self.upload_id))

        # Before mentions can be registered the people mentioned need
        # to be created
        people_mentioned = self.process_people(emlo_mention_ids, mention_ids)
        self.logger.info(people_mentioned)

        mention_id = session.query(CofkCollectPersonMentionedInWork.mention_id) \
            .order_by(desc(CofkCollectPersonMentionedInWork.mention_id)).first()

        if not mention_id:
            mention_id = 1
        else:
            mention_id = mention_id[0]

        for p in people_mentioned:
            person_mention = CofkCollectPersonMentionedInWork(
                mention_id=mention_id,
                upload_id=self.upload_id,
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
            .filter_by(location_id=loc_id, upload_id=self.upload_id).first()

        if location_id is None:
            location_id = session.query(CofkCollectLocation.location_id) \
                .order_by(desc(CofkCollectLocation.location_id)).first()

            if not location_id:
                location_id = 1
            else:
                location_id = location_id[0] + 1

            loc = CofkCollectLocation(
                upload_id=self.upload_id,
                location_id=location_id,
                location_name=name)
            session.add(loc)
            session.commit()

            self.logger.info("Created location {}, upload_id #{}".format(
                name, self.upload_id))
        else:
            location_id = location_id[0]

        return location_id

    def get_person_id(self, person_id=None):
        if person_id:
            return session.query(CofkCollectPerson.iperson_id) \
                .filter_by(iperson_id=person_id, upload_id=self.upload_id).first()
        else:
            return session.query(CofkCollectPerson.iperson_id) \
                .order_by(desc(CofkCollectPerson.iperson_id)).first()

    def process_people(self, ids: str, names: str) -> List[int]:
        """
        This method assumes that the data holds correct information on persons.
        That means that if the id and name specific to the current upload do not exist,
        they are created.

        Persons created seem to be specific to the upload. The cofk_collect_person table
        has upload_id as a primary key. This means that persons at this stage (pre-review)
        do not seem to be global and there is likely massive duplication in the
        cofk_collect_person table.
        :param ids:
        :param names:
        :return:
        """
        ids = ids.split(';')
        names = names.split(';')
        people = []

        # If there are more names than ids then a new person needs to be created
        if len(ids) < len(names):
            self.logger.debug("More names than ids.")
            new_names = names[len(ids):]
            last_person_id = self.get_person_id()

            for name in new_names:
                last_person_id = last_person_id + 1
                new_person = CofkCollectPerson(
                    upload_id=self.upload_id,
                    iperson_id=last_person_id,
                    primary_name=name)
                session.add(new_person)
                session.commit()
                people.append(last_person_id)

        for person in zip(ids, names):
            # Check if person already exists
            person_id = self.get_person_id(person[0])

            if person_id is None:
                self.logger.info("Creating new person {}-{}".format(person[0], person[1]))
                # Person does not exist, so we need to create it
                new_person = CofkCollectPerson(
                    upload_id=self.upload_id,
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
                upload_id=self.upload_id,
                iwork_id=self.iwork_id,
                language_code=language)
            language_id = language_id + 1

            session.add(lang)
        session.commit()

    def process_resource(self):
        resource_name = self.non_work_data['resource_name'] if 'resource_name' in self.non_work_data else None
        resource_url = self.non_work_data['resource_url'] if 'resource_url' in self.non_work_data else None
        resource_details = self.non_work_data['resource_details'] if 'resource_details' in self.non_work_data else None

        self.logger.info("Processing resource , iwork_id #{}, upload_id #{}".format(
            self.iwork_id, self.upload_id))

        resource_id = session.query(CofkCollectWorkResource.resource_id) \
            .order_by(desc(CofkCollectWorkResource.resource_id)).first()

        if not resource_id:
            resource_id = 1
        else:
            resource_id = resource_id[0] + 1

        resource = CofkCollectWorkResource(
            upload_id=self.upload_id,
            iwork_id=self.iwork_id,
            resource_id=resource_id,
            resource_name=resource_name,
            resource_url=resource_url,
            resource_details=resource_details)
        session.add(resource)
        session.commit()

        self.logger.info("Resource created #{} iwork_id #{}, upload_id #{}".format(resource_id,
            self.iwork_id, self.upload_id))


class CofkUploadExcelFile:

    def __init__(self, logger: logging.Logger, filename: str):
        """
        :param logger:
        :param filename:
        """
        self.works = None
        self.logger = logger
        self.filename = filename
        self.repositories = []
        self.locations = []
        self.people = []
        self.manifestations = []

        self.wb = self.load_file(filename)

        self.check_sheets()

        self.validate_data()

        self.upload = self.create_upload()

        # It's best to process the sheets in reverse order, starting with repositories/institutions
        self.process_repositories()

        # The next sheet is places/locations
        self.process_locations()

        # The next sheet is people
        self.process_people()

        # Second last but not least, the works themselves
        self.process_work()

        # The last sheet is manifestations
        self.process_manifestations()

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
            raise ValueError("File {} not found".format(filename))

        return wb

    def check_sheets(self):
        # Verify all required sheets are present
        if not all(elem in list(self.wb.keys()) for elem in mandatory_sheets):
            msg = "Missing sheet/s: {}".format(",".join(list(mandatory_sheets - self.wb.keys())))
            self.logger.error(msg)
            raise ValueError(msg)

        self.logger.info("All {} sheets verified".format(len(mandatory_sheets)))

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
                                uploader_email='anusha@cottagelabs.com',
                                upload_description=self.filename + " " + str(datetime.now(tz=None)))
        session.add(upl)
        session.commit()

        self.logger.info("Upload {} created".format(upl.upload_id))

        return upl

    def process_repositories(self):
        repositories = CofkRepositories(logger=self.logger, upload_id=self.upload.upload_id,
                                        sheet_data=self.wb['Repositories'].where(pd.notnull(self.wb['Repositories']),
                                                                                 None))
        self.repositories = repositories.ids

    def process_locations(self):
        locations = CofkLocations(logger=self.logger, upload_id=self.upload.upload_id,
                                  sheet_data=self.wb['Places'].where(pd.notnull(self.wb['Places']), None))
        self.locations = locations.ids

    def process_people(self):
        people = CofkPeople(logger=self.logger, upload_id=self.upload.upload_id,
                            sheet_data=self.wb['People'].where(pd.notnull(self.wb['People']), None))
        self.people = people.ids

    def process_manifestations(self):
        manifestation = CofkManifestations(logger=self.logger, upload_id=self.upload.upload_id,
                                           sheet_data=self.wb['Manifestation'].where(
                                               pd.notnull(self.wb['Manifestation']), None))
        self.manifestations = manifestation.ids

    def process_work(self):
        works = CofkWork(logger=self.logger, upload_id=self.upload.upload_id,
                         sheet_data=self.wb['Work'].where(pd.notnull(self.wb['Work']), None))
        self.works = works.ids
        self.upload.total_works = len(works.ids)

    def validate_data(self):
        validate_work(self.wb['Work'].where(pd.notnull(self.wb['Work']), None))

        validate_manifestation(self.wb['Manifestation'].where(pd.notnull(self.wb['Manifestation']), None))



