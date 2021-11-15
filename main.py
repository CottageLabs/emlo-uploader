import logging

from db import CofkCollectStatu, CofkCollectUpload, CofkCollectWork, CofkCollectLocation, session
import pandas as pd

file_formats = ["*.xls", "*.xlsx"]

LOG_FORMAT = ('%(levelname) -10s %(asctime)s %(name) -30s %(funcName) -35s %(lineno) -5d: %(message)s')
LOGGER = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)

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
r_insert = df.iloc[1].to_dict()

# Establish what keys are surplus to table
r_missing = list(set(wb[sheet].iloc[1].to_dict().keys()) - set([c for c in CofkCollectWork.__dict__.keys()]))

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


# Deleting surplus keys
for m in r_missing:
    print(r_insert[m])
    del r_insert[m]

# CofkCollectStatu needs to be populated with some values
# stat = CofkCollectStatu(status_id=4, status_desc="Stuff")
# session.add(stat)
# session.commit()


upl = CofkCollectUpload(upload_username='cofka')
session.add(upl)
session.commit()


loc = CofkCollectLocation(upload_id=upl.upload_id, location_id=1000)

session.add(loc)
session.commit()

r_insert['upload_id'] = upl.upload_id
r_insert['origin_id'] = loc.location_id
r_insert['destination_id'] = loc.location_id

w = CofkCollectWork(**r_insert)

print(r_missing)

session.add(w)
session.commit()
