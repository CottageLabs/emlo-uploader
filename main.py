import logging

from sqlalchemy import desc

import db
from db import CofkCollectStatu, CofkCollectUpload, CofkCollectWork, CofkCollectLocation, session, \
    CofkCollectPersonMentionedInWork, CofkCollectPerson
import pandas as pd

LOG_FORMAT = ('%(levelname) -10s %(asctime)s %(name) -30s %(funcName) -35s %(lineno) -5d: %(message)s')
LOGGER = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)


def preprocess_languages(r_surplus, upload_id, iwork_id):
    work_languages = []

    if r_surplus['hashebrew']:
        work_languages.append("heb")

    if r_surplus['hasarabic']:
        work_languages.append("ara")

    if r_surplus['hasgreek']:
        work_languages.append("ell")

    if r_surplus['haslatin']:
        work_languages.append("lat")

    if len(work_languages):
        process_languages(work_languages, upload_id, iwork_id)


def process_authors(author_ids, author_names, upload_id, iwork_id):
    authors = process_people(str(author_ids),
                             str(author_names),
                             upload_id)

    author_id = session.query(db.CofkCollectAuthorOfWork.author_id) \
        .order_by(desc(db.CofkCollectAuthorOfWork.author_id)).first()

    if not author_id:
        author_id = 1
    else:
        author_id = author_id[0]

    for p in authors:
        author = db.CofkCollectAuthorOfWork(
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

    addressee_id = session.query(db.CofkCollectAddresseeOfWork.addressee_id) \
        .order_by(desc(db.CofkCollectAddresseeOfWork.addressee_id)).first()

    if not addressee_id:
        addressee_id = 1
    else:
        addressee_id = addressee_id[0]

    for p in addressees:
        addressee = db.CofkCollectAddresseeOfWork(
            addressee_id=addressee_id,
            upload_id=upload_id,
            iwork_id=iwork_id,
            iperson_id=p)
        addressee_id = addressee_id + 1

        session.add(addressee)
    session.commit()


def process_row(r_insert):
    # Establish what keys are surplus to table
    r_missing = list(set(r_insert.keys()) - set([c for c in CofkCollectWork.__dict__.keys()]))

    # Start by initializing an upload
    upl = CofkCollectUpload(upload_username='cofka')
    session.add(upl)
    session.commit()

    r_surplus = {}
    # Deleting surplus keys
    for m in r_missing:
        r_surplus[m] = r_insert[m]
        del r_insert[m]

    # CofkCollectStatu needs to be populated with some values
    # stat = CofkCollectStatu(status_id=4, status_desc="Stuff")
    # session.add(stat)
    # session.commit()

    r_insert['upload_id'] = upl.upload_id
    r_insert['origin_id'] = process_location(upload_id=upl.upload_id,
                     id=r_insert['origin_id'],
                     name=r_surplus['origin_name'])
    r_insert['destination_id'] = process_location(upload_id=upl.upload_id,
                     id=r_insert['destination_id'],
                     name=r_surplus['destination_name'])

    w = CofkCollectWork(**r_insert)

    print(r_insert)

    session.add(w)
    session.commit()

    process_mentions(r_surplus['emlo_mention_id'], r_surplus['mention_id'],
                     upl.upload_id, w.iwork_id)

    preprocess_languages(r_surplus, upl.upload_id, w.iwork_id)

    if r_surplus['resource_name'] or r_surplus['resource_url']:
        process_resource(upl.upload_id, w.iwork_id, r_surplus['resource_name'],
                         r_surplus['resource_url'], r_surplus['resource_details'])

    process_authors(r_surplus['author_ids'], r_surplus['author_names'],
                    upl.upload_id, w.iwork_id)

    process_addressees(r_surplus['addressee_ids'], r_surplus['addressee_names'],
                       upl.upload_id, w.iwork_id)


def process_mentions(emlo_mention_ids, mention_ids, upload_id, iwork_id):
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


def process_location(upload_id, id, name):
    location_id = session.query(CofkCollectLocation.location_id) \
        .filter_by(location_id=id, upload_id=upload_id).first()

    if location_id is None:
        location_id = session.query(db.CofkCollectLocation.location_id) \
            .order_by(desc(db.CofkCollectLocation.location_id)).first()

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


def process_people(emlo_mention_ids, mention_ids, upload_id):
    people = []
    for p in zip(emlo_mention_ids.split(';'), mention_ids.split(';')):
        # NOTE THIS IS FILTERING BY PERSON_ID AND UPLOAD_ID SO
        # THERE IS BOUND TO BE MASSIVE DUPLICATION IN THIS TABLE
        person_id = session.query(CofkCollectPerson.iperson_id)\
            .filter_by(iperson_id=p[0],
                       upload_id=upload_id).first()

        if person_id is None:
            # Person does not exist, so we need to create it
            new_person = CofkCollectPerson(upload_id=upload_id,
                                           iperson_id=p[0],
                                           primary_name=p[1])
            session.add(new_person)
            session.commit()

            people.append(new_person.iperson_id)

            # person_id = new_person.iperson_id
            # print(person_id)
        else:
            people.append(person_id[0])

        return people


def process_languages(has_language, upload_id, iwork_id):
    language_id = session.query(db.CofkCollectLanguageOfWork.language_of_work_id) \
        .order_by(desc(db.CofkCollectLanguageOfWork.language_of_work_id)).first()

    if not language_id:
        language_id = 1
    else:
        language_id = language_id[0]

    for language in has_language:
        l = db.CofkCollectLanguageOfWork(
            language_of_work_id=language_id,
            upload_id=upload_id,
            iwork_id=iwork_id,
            language_code=language)
        language_id = language_id + 1

        session.add(l)
    session.commit()


def process_resource(upload_id, iwork_id, resource_name, resource_url, resource_details):
    resource_id = session.query(db.CofkCollectWorkResource.resource_id) \
        .order_by(desc(db.CofkCollectWorkResource.resource_id)).first()

    if not resource_id:
        resource_id = 1

    resource = db.CofkCollectWorkResourc(upload_id=upload_id,
                                         iwork_id=iwork_id,
                                         resource_id=resource_id,
                                         resource_name=resource_name,
                                         resource_url=resource_url,
                                         resource_details=resource_details)
    session.add(resource)
    session.commit()


# Setting sheet_name to None returns a dict with sheet name as key and data frame as value
# Occasionally additional data is included that we cannot parse so we ignore "Unnamed:" columns
wb = pd.read_excel("excel/INGEST_SP_Pley_S10400_2021.10.12a.xlsx", sheet_name=None,
                   usecols=lambda c: not c.startswith('Unnamed:'))

sheet = list(wb.keys())[0]
columns = wb[sheet].columns.to_list()
print(columns)

# Importing first sheet as a dataframe and converting empty values to 0
df = wb[sheet].where(pd.notnull(wb[sheet]), 0)

# I need a mapping between sheet names and tables

# Take the first row and convert to key value dict pairs
row = df.iloc[1].to_dict()

process_row(row)
'''
for row in df.itertuples():
    if row[0] > 0:
        process_row(row._asdict())
'''
# Missing for work
# ['mention_id', 'addressee_ids', 'hashebrew', 'hasgreek', 'resource_url', 'author_ids', 'emlo_mention_id',
# 'addressee_names', 'language_id', 'resource_name', 'author_names', 'answererby', 'resource_details',
# 'origin_name', 'haslatin', 'hasarabic', 'destination_name']

# 'emlo_mention_id', 'mention_id', => cofk_collect_person_mentioned_in_work
#  'hashebrew', 'hasgreek', 'haslatin', 'hasarabic' => cofk_collect_language_of_work
#  'resource_name',  'resource_url', 'resource_details', => cofk_collect_work_resource
#  'author_names', 'author_ids', => cofk_collect_author_of_work
#  'addressee_ids', 'addressee_names' => cofk_collect_addressee_of_work
# 'origin_name' / IDs provided but not name
# 'destination_name'
# 'answererby', ????

# r_insert['upload_id'] = '0'
# r_insert['destination_id'] = 4

# Mention_id is not used
# https://github.com/CottageLabs/site-edit/blob/354f025b193f98addeb715f1224a2db9de3736ad/docker-uploader/uploader/js/transIngest.js#L444


