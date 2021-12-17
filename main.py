import logging
import sys

import pandas as pd

from constants import mandatory_sheets
from processing import process_work

LOG_FORMAT = '%(levelname) -10s %(asctime)s %(name) -30s %(funcName) -35s %(lineno) -5d: %(message)s'
logger = logging.getLogger(__name__)
logging.basicConfig(filename='emlo_uploader.log', level=logging.DEBUG, format=LOG_FORMAT)

filename = "excel/INGEST_SP_Pley_S10400_2021.10.12a.xlsx"

# Setting sheet_name to None returns a dict with sheet name as key and data frame as value
# Occasionally additional data is included that we cannot parse, so we ignore "Unnamed:" columns
# Supports xls, xlsx, xlsm, xlsb, odf, ods and odt file extensions read from a local filesystem or URL.
# https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_excel.html
try:
    wb = pd.read_excel(filename, sheet_name=None,
                       usecols=lambda c: not c.startswith('Unnamed:'))
    logger.info("Successfully read file: {}".format(filename))
except FileNotFoundError as fnfe:
    logger.error("File {} not found".format(filename))
    sys.exit(1)

# Verify all required sheets are present
if len(mandatory_sheets - wb.keys()) > 0:
    logging.error("Missing sheet/s: {}".format(",".join(list(mandatory_sheets - wb.keys()))))
    sys.exit(1)

# Importing "Work" sheet as a dataframe and converting empty values to 0
df = wb['Work'].where(pd.notnull(wb['Work']), 0)

# Take the first row and convert to key value dict pairs
row = df.iloc[1].to_dict()
process_work(logger, row)

