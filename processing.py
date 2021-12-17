from typing import List

from sqlalchemy import desc

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


def preprocess_languages(non_work_data_raw: set, upload_id: int, iwork_id: int):
    work_languages = []

    if non_work_data_raw['hashebrew']:
        work_languages.append("heb")

    if non_work_data_raw['hasarabic']:
        work_languages.append("ara")

    if non_work_data_raw['hasgreek']:
        work_languages.append("ell")

    if non_work_data_raw['haslatin']:
        work_languages.append("lat")

    if len(work_languages):
        process_languages(work_languages, upload_id, iwork_id)


def process_authors(author_ids, author_names, upload_id, iwork_id):
    authors = process_people(str(author_ids),
                             str(author_names),
                             upload_id)

    author_id = session.query(CofkCollectAuthorOfWork.author_id) \
        .order_by(desc(CofkCollectAuthorOfWork.author_id)).first()

    if not author_id:
        author_id = 1
    else:
        author_id = author_id[0]

    for p in authors:
        author = CofkCollectAuthorOfWork(
            author_id=author_id,
            upload_id=upload_id,
            iwork_id=iwork_id,
            iperson_id=p)
        author_id = author_id + 1

        session.add(author)
    session.commit()


def process_addressees(addressee_ids, addressee_names, upload_id, iwork_id):
    addressees = process_people(str(addressee_ids),
                                str(addressee_names),
                                upload_id)

    addressee_id = session.query(CofkCollectAddresseeOfWork.addressee_id) \
        .order_by(desc(CofkCollectAddresseeOfWork.addressee_id)).first()

    if not addressee_id:
        addressee_id = 1
    else:
        addressee_id = addressee_id[0]

    for p in addressees:
        addressee = CofkCollectAddresseeOfWork(
            addressee_id=addressee_id,
            upload_id=upload_id,
            iwork_id=iwork_id,
            iperson_id=p)
        addressee_id = addressee_id + 1

        session.add(addressee)
    session.commit()


def create_upload() -> CofkCollectUpload:
    upl = CofkCollectUpload(upload_username='cofkcottage')
    session.add(upl)
    session.commit()

    return upl


def process_work(logger, work_data_raw):
    """
    This method processes one row of data from the Excel sheet.

    :param logger:
    :param work_data_raw:
    :return:
    """
    # Start by initializing an upload
    upload = create_upload()
    work_data_raw['upload_id'] = upload.upload_id

    logger.info("Processing work, iwork_id #{}, upload_id #{}".format(
        work_data_raw['iwork_id'], upload.upload_id))

    # Isolating data relevant to a work
    non_work_keys = list(set(work_data_raw.keys()) - set([c for c in CofkCollectWork.__dict__.keys()]))

    # This set will contain any raw data about:
    # 1. origin location
    # 2. destination location
    # 3. people mentioned
    # 4. languages used
    # 5. resources
    # 6. authors
    # 7. addressees
    non_work_data_raw = {}

    # Removing non work data so that variable work_data_raw can be used to pass parameters
    # to create a CofkCollectWork object
    for m in non_work_keys:
        non_work_data_raw[m] = work_data_raw[m]
        del work_data_raw[m]

    # Origin location needs to be processed before work is created
    work_data_raw['origin_id'] = process_location(
        upload_id=upload.upload_id,
        loc_id=work_data_raw['origin_id'],
        name=non_work_data_raw['origin_name'])

    # Destination location needs to be processed before work is created
    work_data_raw['destination_id'] = process_location(
        upload_id=upload.upload_id,
        loc_id=work_data_raw['destination_id'],
        name=non_work_data_raw['destination_name'])

    # Creating the work itself
    work = CofkCollectWork(**work_data_raw)
    session.add(work)
    session.commit()

    # Processing people mentioned in work
    process_mentions(non_work_data_raw['emlo_mention_id'], non_work_data_raw['mention_id'],
                     upload.upload_id, work.iwork_id)

    # Processing languages used in work
    preprocess_languages(non_work_data_raw, upload.upload_id, work.iwork_id)

    # Processing resources in work
    if 'resource_name' in non_work_data_raw or 'resource_url' in non_work_data_raw:
        process_resource(upload.upload_id, work.iwork_id, non_work_data_raw)

    process_authors(non_work_data_raw['author_ids'], non_work_data_raw['author_names'],
                    upload.upload_id, work.iwork_id)

    process_addressees(non_work_data_raw['addressee_ids'], non_work_data_raw['addressee_names'],
                       upload.upload_id, work.iwork_id)


def process_mentions(emlo_mention_ids: str, mention_ids: str, upload_id: int, iwork_id: int):
    # Before mentions can be registered the people mentioned need
    # to be created
    people_mentioned = process_people(str(emlo_mention_ids),
                                      str(mention_ids),
                                      upload_id)

    mention_id = session.query(CofkCollectPersonMentionedInWork.mention_id) \
        .order_by(desc(CofkCollectPersonMentionedInWork.mention_id)).first()

    if not mention_id:
        mention_id = 1
    else:
        mention_id = mention_id[0]

    for p in people_mentioned:
        person_mention = CofkCollectPersonMentionedInWork(
            mention_id=mention_id,
            upload_id=upload_id,
            iwork_id=iwork_id,
            iperson_id=p)
        mention_id = mention_id + 1

        session.add(person_mention)
    session.commit()


def process_location(upload_id, loc_id, name) -> int:
    """
    Method that checks if a location specific to the location id and upload exists,
    if so it returns the id provided id if not a new location is created incrementing
    the highest location id by one.
    :param upload_id:
    :param loc_id:
    :param name:
    :return:
    """
    location_id = session.query(CofkCollectLocation.location_id) \
        .filter_by(location_id=loc_id, upload_id=upload_id).first()

    if location_id is None:
        location_id = session.query(CofkCollectLocation.location_id) \
            .order_by(desc(CofkCollectLocation.location_id)).first()

        if not location_id:
            location_id = 1
        else:
            location_id = location_id[0] + 1

        loc = CofkCollectLocation(upload_id=upload_id,
                                  location_id=location_id,
                                  location_name=name)

        session.add(loc)
        session.commit()

    return location_id


def process_people(emlo_mention_ids: str, mention_ids: str, upload_id: int) -> List[int]:
    people = []
    for p in zip(emlo_mention_ids.split(';'), mention_ids.split(';')):
        # NOTE THIS IS FILTERING BY PERSON_ID AND UPLOAD_ID SO
        # THERE IS BOUND TO BE MASSIVE DUPLICATION IN THIS TABLE
        person_id = session.query(CofkCollectPerson.iperson_id) \
            .filter_by(iperson_id=p[0],
                       upload_id=upload_id).first()

        if person_id is None:
            # Person does not exist, so we need to create it
            new_person = CofkCollectPerson(
                upload_id=upload_id,
                iperson_id=p[0],
                primary_name=p[1])
            session.add(new_person)
            session.commit()

            people.append(new_person.iperson_id)
        else:
            people.append(person_id[0])

    return people


def process_languages(has_language: List[str], upload_id: int, iwork_id: int):
    language_id = session.query(CofkCollectLanguageOfWork.language_of_work_id) \
        .order_by(desc(CofkCollectLanguageOfWork.language_of_work_id)).first()

    if not language_id:
        language_id = 1
    else:
        language_id = language_id[0]

    for language in has_language:
        lang = CofkCollectLanguageOfWork(
            language_of_work_id=language_id,
            upload_id=upload_id,
            iwork_id=iwork_id,
            language_code=language)
        language_id = language_id + 1

        session.add(lang)
    session.commit()


def process_resource(upload_id: int, iwork_id: int, non_work_data_raw: set):
    resource_name = non_work_data_raw['resource_name'] if 'resource_name' in non_work_data_raw else None
    resource_url = non_work_data_raw['resource_url'] if 'resource_url' in non_work_data_raw else None
    resource_details = non_work_data_raw['resource_details'] if 'resource_details' in non_work_data_raw else None

    resource_id = session.query(CofkCollectWorkResource.resource_id) \
        .order_by(desc(CofkCollectWorkResource.resource_id)).first()

    if not resource_id:
        resource_id = 1
    else:
        resource_id = resource_id[0] + 1

    resource = CofkCollectWorkResource(
        upload_id=upload_id,
        iwork_id=iwork_id,
        resource_id=resource_id,
        resource_name=resource_name,
        resource_url=resource_url,
        resource_details=resource_details)
    session.add(resource)
    session.commit()
