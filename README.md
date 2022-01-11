# EMLO uploader component

This is a refactoring of [the uploader component](https://github.com/culturesofknowledge/site-edit/tree/master/docker-uploader) of
the [EMLO](http://emlo.bodleian.ox.ac.uk/) resource at Oxford.

The main purpose is to update the Python version from 2.7 to 3.8+ and
simplify the ingest process which currently uses MongoDB as a sort of
staging database before importing the data into a Postgres database.
Instead, this component reads the excel files and loads directly into
Postgres.

### Dependencies
* Python 3.8
* SQLAlchemy 1.4.27
* Pandas 1.3.4
* Pika 1.2.0
* [Wait-for-it](https://github.com/vishnubob/wait-for-it) (for 
Docker-compose synchronization)
 
The emlo-uploader docker image is based off of [amancevice/pandas](https://github.com/amancevice/docker-pandas),
a pre-built docker container with Pandas set up. Pandas is used for easy
handling of the spreadsheet data, auto-typing and more.

see requirements.txt

## Deployment
Deployed with docker-compose. For production set database environment variables
in db.env to correct values, the database name is "_ouls_".

The docker-compose file is intended for development only. It includes a PGAdmin
container.

## How it works

`main.py` is mostly untouched in order to stay true to the original pipeline, it
listens to a RabbitMQ channel to be pinged with information about a file upload
location. Feedback is then relayed back to `emlo-edit-php/core/upload.php`.

In the meantime the spreadsheet is first validated by a few checks, it is mandatory
to have the number and names of sheets defined in `mandatory_sheets` in 
`constants.py`, there are a few checks based off of the list provided
`Spreadsheet_preUpload_check_2020_rev.May21.docx`. If any piece of data fails a
test a ValueError is raised immediately. This means that:
1) the spreadsheet will not be processed
2) it is not known whether there are more problems with the spreadsheet, meaning
that the user might fix the problem, re-upload and hit the next problem

If everything is ready the spreadsheet is processed by `processing.py`.

## Todo
* Cleanup files post-processing
* Decide on correct credentials for uploads