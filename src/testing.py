import logging
import sys

from processing import CofkUploadExcelFile


LOG_FORMAT = '%(levelname) -10s %(asctime)s %(name) -30s %(funcName) -35s %(lineno) -5d: %(message)s'
logger = logging.getLogger(__name__)
logging.basicConfig(filename='../emlo_uploader.log', level=logging.INFO, format=LOG_FORMAT)

try:
    efp = CofkUploadExcelFile(logger=logger, filename=sys.argv[1])
except ValueError as ve:
    print(str(ve))
