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

see requirements.txt