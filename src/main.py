import json
import logging

import pika
from processing import CofkUploadExcelFile


LOG_FORMAT = '%(levelname) -10s %(asctime)s %(name) -30s %(funcName) -35s %(lineno) -5d: %(message)s'
logger = logging.getLogger(__name__)
logging.basicConfig(filename='../emlo_uploader.log', level=logging.INFO, format=LOG_FORMAT)

credentials = pika.PlainCredentials('guest', 'guest')
connection_parameters = pika.ConnectionParameters('rabbitmq', 5672, '/', credentials)

connection = pika.BlockingConnection(connection_parameters)
channel = connection.channel()

channel.queue_declare(queue='uploader')
channel.queue_declare(queue='uploader-processed')


def callback(ch, method, properties, body):
    logger.info(body)

    data = json.loads(body)

    try:
        efp = CofkUploadExcelFile(logger=logger, filename=data['filelocation'])

        data['output'] = "Processed {}. Works: {}. Institutions: {}. Locations: {}. People: {}. Manifestations: {}"\
            .format(data['filelocation'], efp.works, efp.repositories, efp.locations, efp.people, efp.manifestations)

        logger.info(data['output'])
    except ValueError as ve:
        data['error'] = str(ve)

    channel.basic_publish(exchange='', routing_key='uploader-processed', body=json.dumps(data))


channel.basic_consume(on_message_callback=callback, queue='uploader', auto_ack=False)

logger.info('Waiting for uploaded excel files')
channel.start_consuming()