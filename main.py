import logging

import pandas as pd

from processing import ExcelFileProcess

LOG_FORMAT = '%(levelname) -10s %(asctime)s %(name) -30s %(funcName) -35s %(lineno) -5d: %(message)s'
logger = logging.getLogger(__name__)
logging.basicConfig(filename='emlo_uploader.log', level=logging.DEBUG, format=LOG_FORMAT)

filename = "excel/INGEST_SP_Pley_S10400_2021.10.12a.xlsx"

efp = ExcelFileProcess(logger=logger, filename=filename)

# Importing "Work" sheet as a dataframe and converting empty values to 0
df = efp.wb['Work'].where(pd.notnull(efp.wb['Work']), 0)

# Take the first row and convert to key value dict pairs
row = df.iloc[1].to_dict()
print(row)
efp.process_work(row)

print(1111)