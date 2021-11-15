# coding: utf-8
from sqlalchemy import Column, DateTime, ForeignKey, Integer, SmallInteger, String, Table, Text, text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


t_cofk_collect_institution = Table(
    'cofk_collect_institution', metadata,
    Column('upload_id', Integer, nullable=False),
    Column('institution_id', Integer, nullable=False),
    Column('union_institution_id', Integer),
    Column('institution_name', Text, nullable=False, server_default=text("''::text")),
    Column('institution_city', Text, nullable=False, server_default=text("''::text")),
    Column('institution_country', Text, nullable=False, server_default=text("''::text")),
    Column('upload_name', String(254)),
    Column('_id', String(32)),
    Column('institution_synonyms', Text),
    Column('institution_city_synonyms', Text),
    Column('institution_country_synonyms', Text)
)


t_cofk_collect_location = Table(
    'cofk_collect_location', metadata,
    Column('upload_id', Integer, nullable=False),
    Column('location_id', Integer, nullable=False),
    Column('union_location_id', Integer),
    Column('location_name', String(500), nullable=False, server_default=text("''::character varying")),
    Column('element_1_eg_room', String(100), nullable=False, server_default=text("''::character varying")),
    Column('element_2_eg_building', String(100), nullable=False, server_default=text("''::character varying")),
    Column('element_3_eg_parish', String(100), nullable=False, server_default=text("''::character varying")),
    Column('element_4_eg_city', String(100), nullable=False, server_default=text("''::character varying")),
    Column('element_5_eg_county', String(100), nullable=False, server_default=text("''::character varying")),
    Column('element_6_eg_country', String(100), nullable=False, server_default=text("''::character varying")),
    Column('element_7_eg_empire', String(100), nullable=False, server_default=text("''::character varying")),
    Column('notes_on_place', Text),
    Column('editors_notes', Text),
    Column('upload_name', String(254)),
    Column('_id', String(32)),
    Column('location_synonyms', Text),
    Column('latitude', String(20)),
    Column('longitude', String(20))
)


t_cofk_collect_manifestation = Table(
    'cofk_collect_manifestation', metadata,
    Column('upload_id', Integer, nullable=False),
    Column('manifestation_id', Integer, nullable=False),
    Column('iwork_id', Integer, nullable=False),
    Column('union_manifestation_id', String(100)),
    Column('manifestation_type', String(3), nullable=False, server_default=text("''::character varying")),
    Column('repository_id', Integer),
    Column('id_number_or_shelfmark', String(500)),
    Column('printed_edition_details', Text),
    Column('manifestation_notes', Text),
    Column('image_filenames', Text),
    Column('upload_name', String(254)),
    Column('_id', String(32))
)


t_cofk_collect_person = Table(
    'cofk_collect_person', metadata,
    Column('upload_id', Integer, nullable=False),
    Column('iperson_id', Integer, nullable=False),
    Column('union_iperson_id', Integer),
    Column('person_id', String(100)),
    Column('primary_name', String(200), nullable=False),
    Column('alternative_names', Text),
    Column('roles_or_titles', Text),
    Column('gender', String(1), nullable=False, server_default=text("''::character varying")),
    Column('is_organisation', String(1), nullable=False, server_default=text("''::character varying")),
    Column('organisation_type', Integer),
    Column('date_of_birth_year', Integer),
    Column('date_of_birth_month', Integer),
    Column('date_of_birth_day', Integer),
    Column('date_of_birth_is_range', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_birth2_year', Integer),
    Column('date_of_birth2_month', Integer),
    Column('date_of_birth2_day', Integer),
    Column('date_of_birth_inferred', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_birth_uncertain', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_birth_approx', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_death_year', Integer),
    Column('date_of_death_month', Integer),
    Column('date_of_death_day', Integer),
    Column('date_of_death_is_range', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_death2_year', Integer),
    Column('date_of_death2_month', Integer),
    Column('date_of_death2_day', Integer),
    Column('date_of_death_inferred', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_death_uncertain', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_death_approx', SmallInteger, nullable=False, server_default=text("0")),
    Column('flourished_year', Integer),
    Column('flourished_month', Integer),
    Column('flourished_day', Integer),
    Column('flourished_is_range', SmallInteger, nullable=False, server_default=text("0")),
    Column('flourished2_year', Integer),
    Column('flourished2_month', Integer),
    Column('flourished2_day', Integer),
    Column('notes_on_person', Text),
    Column('editors_notes', Text),
    Column('upload_name', String(254)),
    Column('_id', String(32))
)


t_cofk_collect_work = Table(
    'cofk_collect_work', metadata,
    Column('upload_id', Integer, nullable=False),
    Column('iwork_id', Integer, nullable=False),
    Column('union_iwork_id', Integer),
    Column('work_id', String(100)),
    Column('date_of_work_as_marked', String(250)),
    Column('original_calendar', String(2), nullable=False, server_default=text("''::character varying")),
    Column('date_of_work_std_year', Integer),
    Column('date_of_work_std_month', Integer),
    Column('date_of_work_std_day', Integer),
    Column('date_of_work2_std_year', Integer),
    Column('date_of_work2_std_month', Integer),
    Column('date_of_work2_std_day', Integer),
    Column('date_of_work_std_is_range', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_work_inferred', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_work_uncertain', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_work_approx', SmallInteger, nullable=False, server_default=text("0")),
    Column('notes_on_date_of_work', Text),
    Column('authors_as_marked', Text),
    Column('authors_inferred', SmallInteger, nullable=False, server_default=text("0")),
    Column('authors_uncertain', SmallInteger, nullable=False, server_default=text("0")),
    Column('notes_on_authors', Text),
    Column('addressees_as_marked', Text),
    Column('addressees_inferred', SmallInteger, nullable=False, server_default=text("0")),
    Column('addressees_uncertain', SmallInteger, nullable=False, server_default=text("0")),
    Column('notes_on_addressees', Text),
    Column('destination_id', Integer),
    Column('destination_as_marked', Text),
    Column('destination_inferred', SmallInteger, nullable=False, server_default=text("0")),
    Column('destination_uncertain', SmallInteger, nullable=False, server_default=text("0")),
    Column('origin_id', Integer),
    Column('origin_as_marked', Text),
    Column('origin_inferred', SmallInteger, nullable=False, server_default=text("0")),
    Column('origin_uncertain', SmallInteger, nullable=False, server_default=text("0")),
    Column('abstract', Text),
    Column('keywords', Text),
    Column('language_of_work', String(255)),
    Column('incipit', Text),
    Column('excipit', Text),
    Column('accession_code', String(250)),
    Column('notes_on_letter', Text),
    Column('notes_on_people_mentioned', Text),
    Column('upload_status', Integer, nullable=False, server_default=text("1")),
    Column('editors_notes', Text),
    Column('_id', String(32)),
    Column('date_of_work2_approx', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_work2_inferred', SmallInteger, nullable=False, server_default=text("0")),
    Column('date_of_work2_uncertain', SmallInteger, nullable=False, server_default=text("0")),
    Column('mentioned_as_marked', Text),
    Column('mentioned_inferred', SmallInteger, nullable=False, server_default=text("0")),
    Column('mentioned_uncertain', SmallInteger, nullable=False, server_default=text("0")),
    Column('notes_on_destination', Text),
    Column('notes_on_origin', Text),
    Column('notes_on_place_mentioned', Text),
    Column('place_mentioned_as_marked', Text),
    Column('place_mentioned_inferred', SmallInteger, nullable=False, server_default=text("0")),
    Column('place_mentioned_uncertain', SmallInteger, nullable=False, server_default=text("0")),
    Column('upload_name', String(254)),
    Column('explicit', Text)
)

from sqlalchemy import create_engine

engine = create_engine('postgresql+psycopg2://postgres:mysecretpassword@localhost:5432')

from sqlalchemy.orm import sessionmaker

session = sessionmaker()
session.configure(bind=engine)
Base.metadata.create_all(engine)