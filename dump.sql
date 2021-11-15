# coding: utf-8
from sqlalchemy import BigInteger, CheckConstraint, Column, Date, DateTime, ForeignKey, ForeignKeyConstraint, Index, Integer, SmallInteger, String, Table, Text, UniqueConstraint, text
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import OID, UUID
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


t_cofk_cardindex_compact_work_view = Table(
    'cofk_cardindex_compact_work_view', metadata,
    Column('description', Text),
    Column('relevant_to_cofk', String),
    Column('editors_notes', Text),
    Column('date_of_work_as_marked', String(250)),
    Column('date_of_work_std_year', Integer),
    Column('date_of_work_std_month', Integer),
    Column('date_of_work_std_day', Integer),
    Column('date_of_work_std', Date),
    Column('sender_or_recipient', Text),
    Column('creators_searchable', Text),
    Column('addressees_searchable', Text),
    Column('places_from_searchable', Text),
    Column('flags', Text),
    Column('images', Text),
    Column('manifestation_type', String(50)),
    Column('manifestations_searchable', Text),
    Column('manifestations_for_display', Text),
    Column('language_of_work', String(255)),
    Column('abstract', Text),
    Column('drawer', String(50)),
    Column('work_to_be_deleted', Text),
    Column('iwork_id', Integer),
    Column('change_timestamp', DateTime),
    Column('change_user', String(50))
)


t_cofk_cardindex_work_view = Table(
    'cofk_cardindex_work_view', metadata,
    Column('description', Text),
    Column('relevant_to_cofk', String),
    Column('editors_notes', Text),
    Column('sender_or_recipient', Text),
    Column('date_of_work_as_marked', String(250)),
    Column('date_of_work_std_year', Integer),
    Column('date_of_work_std_month', Integer),
    Column('date_of_work_std_day', Integer),
    Column('date_of_work_std', Date),
    Column('creators_searchable', Text),
    Column('places_from_searchable', Text),
    Column('addressees_searchable', Text),
    Column('creators_for_display', Text),
    Column('places_from_for_display', Text),
    Column('addressees_for_display', Text),
    Column('flags', Text),
    Column('images', Text),
    Column('manifestation_type', String(50)),
    Column('manifestations_searchable', Text),
    Column('manifestations_for_display', Text),
    Column('language_of_work', String(255)),
    Column('abstract', Text),
    Column('drawer', String(50)),
    Column('people_mentioned', Text),
    Column('original_notes', Text),
    Column('work_to_be_deleted', Text),
    Column('iwork_id', Integer),
    Column('change_timestamp', DateTime),
    Column('change_user', String(50)),
    Column('work_id', String(100))
)


class CofkCollectStatu(Base):
    __tablename__ = 'cofk_collect_status'

    status_id = Column(Integer, primary_key=True)
    status_desc = Column(String(100), nullable=False)
    editable = Column(SmallInteger, nullable=False, server_default=text("1"))


class CofkCollectToolUser(Base):
    __tablename__ = 'cofk_collect_tool_user'

    tool_user_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_collect_tool_user_id_seq'::regclass)"))
    tool_user_email = Column(String(100), nullable=False, unique=True)
    tool_user_surname = Column(String(100), nullable=False)
    tool_user_forename = Column(String(100), nullable=False)
    tool_user_pw = Column(String(100), nullable=False)


t_cofk_collect_work_summary_view = Table(
    'cofk_collect_work_summary_view', metadata,
    Column('source_of_data', String(250)),
    Column('uploader_email', String(250)),
    Column('status_desc', String(100)),
    Column('union_iwork_id', Integer),
    Column('editors_notes', Text),
    Column('date_of_work', String(32)),
    Column('date_of_work_as_marked', String(250)),
    Column('original_calendar', String(30)),
    Column('notes_on_date_of_work', Text),
    Column('authors', Text),
    Column('authors_as_marked', Text),
    Column('notes_on_authors', Text),
    Column('origin', Text),
    Column('origin_as_marked', Text),
    Column('addressees', Text),
    Column('addressees_as_marked', Text),
    Column('notes_on_addressees', Text),
    Column('destination', Text),
    Column('destination_as_marked', Text),
    Column('manifestations', Text),
    Column('abstract', Text),
    Column('keywords', Text),
    Column('languages_of_work', Text),
    Column('subjects_of_work', Text),
    Column('incipit', Text),
    Column('excipit', Text),
    Column('people_mentioned', Text),
    Column('notes_on_people_mentioned', Text),
    Column('places_mentioned', Text),
    Column('issues', Text),
    Column('notes_on_letter', Text),
    Column('related_resources', Text),
    Column('upload_id', Integer),
    Column('work_id_in_tool', Integer),
    Column('contributed_work_id', Integer)
)


class CofkHelpPage(Base):
    __tablename__ = 'cofk_help_pages'

    page_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_help_pages_page_id_seq'::regclass)"))
    page_title = Column(String(500), nullable=False)
    custom_url = Column(String(500))
    published_text = Column(Text, nullable=False, server_default=text("'Sorry, no help currently available.'::text"))
    draft_text = Column(Text)


class CofkLookupCatalogue(Base):
    __tablename__ = 'cofk_lookup_catalogue'

    catalogue_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_lookup_catalogue_id_seq'::regclass)"))
    catalogue_code = Column(String(100), nullable=False, unique=True, server_default=text("''::character varying"))
    catalogue_name = Column(String(500), nullable=False, unique=True, server_default=text("''::character varying"))
    is_in_union = Column(Integer, nullable=False, server_default=text("1"))
    publish_status = Column(SmallInteger, nullable=False, server_default=text("0"))


class CofkLookupDocumentType(Base):
    __tablename__ = 'cofk_lookup_document_type'

    document_type_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_lookup_document_type_id_seq'::regclass)"))
    document_type_code = Column(String(3), nullable=False, unique=True)
    document_type_desc = Column(String(100), nullable=False)


class CofkMenu(Base):
    __tablename__ = 'cofk_menu'
    __table_args__ = (
        CheckConstraint('((has_children = 0) AND (class_name IS NOT NULL) AND (method_name IS NOT NULL)) OR ((has_children = 1) AND (class_name IS NULL) AND (method_name IS NULL))'),
        CheckConstraint('(called_as_popup = 0) OR (called_as_popup = 1)')
    )

    menu_item_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_menu_item_id_seq'::regclass)"))
    menu_item_name = Column(Text, nullable=False)
    menu_order = Column(Integer, server_default=text("nextval('cofk_menu_order_seq'::regclass)"))
    parent_id = Column(ForeignKey('cofk_menu.menu_item_id'))
    has_children = Column(Integer, nullable=False, server_default=text("0"))
    class_name = Column(String(100))
    method_name = Column(String(100))
    user_restriction = Column(String(30), nullable=False, server_default=text("''::character varying"))
    hidden_parent = Column(Integer)
    called_as_popup = Column(Integer, nullable=False, server_default=text("0"))
    collection = Column(String(20), nullable=False, server_default=text("''::character varying"))

    parent = relationship('CofkMenu', remote_side=[menu_item_id])


class CofkReportGroup(Base):
    __tablename__ = 'cofk_report_groups'

    report_group_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_report_groups_report_group_id_seq'::regclass)"))
    report_group_title = Column(Text)
    report_group_order = Column(Integer, nullable=False, server_default=text("1"))
    on_main_reports_menu = Column(Integer, nullable=False, server_default=text("0"))
    report_group_code = Column(String(100))


t_cofk_report_outputs = Table(
    'cofk_report_outputs', metadata,
    Column('output_id', String(250), nullable=False, server_default=text("''::character varying")),
    Column('line_number', Integer, nullable=False, server_default=text("0")),
    Column('line_text', Text)
)


class CofkRole(Base):
    __tablename__ = 'cofk_roles'

    role_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_roles_role_id_seq'::regclass)"))
    role_code = Column(String(20), nullable=False, unique=True, server_default=text("''::character varying"))
    role_name = Column(Text, nullable=False, unique=True, server_default=text("''::text"))

    cofk_users = relationship('CofkUser', secondary='cofk_user_roles')


class CofkUnionAuditLiteral(Base):
    __tablename__ = 'cofk_union_audit_literal'

    audit_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_audit_id_seq'::regclass)"))
    change_timestamp = Column(DateTime, index=True, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, index=True, server_default=text("\"current_user\"()"))
    change_type = Column(String(3), nullable=False)
    table_name = Column(String(100), nullable=False)
    key_value_text = Column(String(100), nullable=False)
    key_value_integer = Column(Integer)
    key_decode = Column(Text)
    column_name = Column(String(100), nullable=False)
    new_column_value = Column(Text)
    old_column_value = Column(Text)


class CofkUnionAuditRelationship(Base):
    __tablename__ = 'cofk_union_audit_relationship'

    audit_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_audit_id_seq'::regclass)"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    change_type = Column(String(3), nullable=False)
    left_table_name = Column(String(100), nullable=False)
    left_id_value_new = Column(String(100), nullable=False, server_default=text("''::character varying"))
    left_id_decode_new = Column(Text, nullable=False, server_default=text("''::text"))
    left_id_value_old = Column(String(100), nullable=False, server_default=text("''::character varying"))
    left_id_decode_old = Column(Text, nullable=False, server_default=text("''::text"))
    relationship_type = Column(String(100), nullable=False)
    relationship_decode_left_to_right = Column(String(100), nullable=False, server_default=text("''::character varying"))
    relationship_decode_right_to_left = Column(String(100), nullable=False, server_default=text("''::character varying"))
    right_table_name = Column(String(100), nullable=False)
    right_id_value_new = Column(String(100), nullable=False, server_default=text("''::character varying"))
    right_id_decode_new = Column(Text, nullable=False, server_default=text("''::text"))
    right_id_value_old = Column(String(100), nullable=False, server_default=text("''::character varying"))
    right_id_decode_old = Column(Text, nullable=False, server_default=text("''::text"))


t_cofk_union_audit_trail_column_view = Table(
    'cofk_union_audit_trail_column_view', metadata,
    Column('dummy_id', Integer),
    Column('changed_field', String)
)


t_cofk_union_audit_trail_table_view = Table(
    'cofk_union_audit_trail_table_view', metadata,
    Column('dummy_id', OID),
    Column('table_name', Text)
)


t_cofk_union_audit_trail_view = Table(
    'cofk_union_audit_trail_view', metadata,
    Column('change_timestamp', DateTime),
    Column('change_user', String(50)),
    Column('table_name', String),
    Column('changed_record_id', String),
    Column('changed_record_desc', Text),
    Column('changed_field', String),
    Column('change_type', String(3)),
    Column('changes_made', Text),
    Column('audit_trail_entry', Integer)
)


t_cofk_union_catalogue_view = Table(
    'cofk_union_catalogue_view', metadata,
    Column('catalogue_id', Integer),
    Column('catalogue_code', String(100)),
    Column('catalogue_name', String(500))
)


class CofkUnionComment(Base):
    __tablename__ = 'cofk_union_comment'

    comment_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_comment_id_seq'::regclass)"))
    comment = Column(Text)
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    creation_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    uuid = Column(UUID, server_default=text("uuid_generate_v4()"))


t_cofk_union_compact_work_view = Table(
    'cofk_union_compact_work_view', metadata,
    Column('description', Text),
    Column('date_of_work_as_marked', String(250)),
    Column('date_of_work_std_year', Integer),
    Column('date_of_work_std_month', Integer),
    Column('date_of_work_std_day', Integer),
    Column('date_of_work_std', Date),
    Column('sender_or_recipient', Text),
    Column('place_to_or_from', Text),
    Column('creators_searchable', Text),
    Column('notes_on_authors', Text),
    Column('addressees_searchable', Text),
    Column('places_from_searchable', Text),
    Column('places_to_searchable', Text),
    Column('flags', Text),
    Column('images', Text),
    Column('manifestations_searchable', Text),
    Column('manifestations_for_display', Text),
    Column('related_resources', Text),
    Column('language_of_work', String(255)),
    Column('subjects', Text),
    Column('abstract', Text),
    Column('general_notes', Text),
    Column('accession_code', String(1000)),
    Column('original_catalogue', String(500)),
    Column('work_to_be_deleted', Text),
    Column('iwork_id', Integer),
    Column('change_timestamp', DateTime),
    Column('change_user', String(50))
)


t_cofk_union_favourite_language_view = Table(
    'cofk_union_favourite_language_view', metadata,
    Column('code_639_3', String(3)),
    Column('code_639_1', String(2)),
    Column('language_name', String(100)),
    Column('language_id', Integer)
)


class CofkUnionImage(Base):
    __tablename__ = 'cofk_union_image'

    image_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_image_id_seq'::regclass)"))
    image_filename = Column(Text)
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    creation_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    thumbnail = Column(Text)
    can_be_displayed = Column(String(1), nullable=False, server_default=text("'Y'::character varying"))
    display_order = Column(Integer, nullable=False, server_default=text("1"))
    licence_details = Column(Text, nullable=False, server_default=text("''::text"))
    licence_url = Column(String(2000), nullable=False, server_default=text("''::character varying"))
    credits = Column(String(2000), nullable=False, server_default=text("''::character varying"))
    uuid = Column(UUID, server_default=text("uuid_generate_v4()"))


class CofkUnionInstitution(Base):
    __tablename__ = 'cofk_union_institution'

    institution_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_institution_id_seq'::regclass)"))
    institution_name = Column(Text, nullable=False, server_default=text("''::text"))
    institution_synonyms = Column(Text, nullable=False, server_default=text("''::text"))
    institution_city = Column(Text, nullable=False, server_default=text("''::text"))
    institution_city_synonyms = Column(Text, nullable=False, server_default=text("''::text"))
    institution_country = Column(Text, nullable=False, server_default=text("''::text"))
    institution_country_synonyms = Column(Text, nullable=False, server_default=text("''::text"))
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    creation_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    editors_notes = Column(Text)
    uuid = Column(UUID, server_default=text("uuid_generate_v4()"))
    address = Column(Text)
    latitude = Column(String(20))
    longitude = Column(String(20))


t_cofk_union_institution_query_view = Table(
    'cofk_union_institution_query_view', metadata,
    Column('institution_id', Integer),
    Column('institution_name', Text),
    Column('institution_synonyms', Text),
    Column('institution_city', Text),
    Column('institution_city_synonyms', Text),
    Column('institution_country', Text),
    Column('institution_country_synonyms', Text),
    Column('related_resources', Text),
    Column('editors_notes', Text),
    Column('images', Text),
    Column('creation_timestamp', DateTime),
    Column('creation_user', String(50)),
    Column('change_timestamp', DateTime),
    Column('change_user', String(50))
)


t_cofk_union_institution_view = Table(
    'cofk_union_institution_view', metadata,
    Column('institution_id', Integer),
    Column('institution_name', Text)
)


t_cofk_union_language_view = Table(
    'cofk_union_language_view', metadata,
    Column('code_639_3', String(3)),
    Column('code_639_1', String(2)),
    Column('language_name', String(100)),
    Column('selected', String),
    Column('language_id', Integer)
)


class CofkUnionLocation(Base):
    __tablename__ = 'cofk_union_location'

    location_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_location_id_seq'::regclass)"))
    location_name = Column(String(500), nullable=False, server_default=text("''::character varying"))
    latitude = Column(String(20))
    longitude = Column(String(20))
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    creation_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    location_synonyms = Column(Text)
    editors_notes = Column(Text)
    element_1_eg_room = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_2_eg_building = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_3_eg_parish = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_4_eg_city = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_5_eg_county = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_6_eg_country = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_7_eg_empire = Column(String(100), nullable=False, server_default=text("''::character varying"))
    uuid = Column(UUID, server_default=text("uuid_generate_v4()"))


t_cofk_union_location_all_works_view = Table(
    'cofk_union_location_all_works_view', metadata,
    Column('location_id', String(100)),
    Column('work_id', String(100)),
    Column('iwork_id', Integer),
    Column('description', Text)
)


t_cofk_union_location_mentioned_view = Table(
    'cofk_union_location_mentioned_view', metadata,
    Column('location_id', String(100)),
    Column('work_id', String(100)),
    Column('iwork_id', Integer),
    Column('description', Text)
)


t_cofk_union_location_recd_view = Table(
    'cofk_union_location_recd_view', metadata,
    Column('location_id', String(100)),
    Column('work_id', String(100)),
    Column('iwork_id', Integer),
    Column('description', Text)
)


t_cofk_union_location_sent_view = Table(
    'cofk_union_location_sent_view', metadata,
    Column('location_id', String(100)),
    Column('work_id', String(100)),
    Column('iwork_id', Integer),
    Column('description', Text)
)


t_cofk_union_location_view = Table(
    'cofk_union_location_view', metadata,
    Column('location_id', Integer),
    Column('location_name', Text),
    Column('editors_notes', Text),
    Column('sent', BigInteger),
    Column('recd', BigInteger),
    Column('all_works', BigInteger),
    Column('researchers_notes', Text),
    Column('related_resources', Text),
    Column('latitude', String(20)),
    Column('longitude', String(20)),
    Column('element_1_eg_room', String(100)),
    Column('element_2_eg_building', String(100)),
    Column('element_3_eg_parish', String(100)),
    Column('element_4_eg_city', String(100)),
    Column('element_5_eg_county', String(100)),
    Column('element_6_eg_country', String(100)),
    Column('element_7_eg_empire', String(100)),
    Column('images', Text),
    Column('change_timestamp', DateTime),
    Column('change_user', String(50))
)


class CofkUnionManifestation(Base):
    __tablename__ = 'cofk_union_manifestation'
    __table_args__ = (
        CheckConstraint('(manifestation_creation_date_approx = 0) OR (manifestation_creation_date_approx = 1)'),
        CheckConstraint('(manifestation_creation_date_inferred = 0) OR (manifestation_creation_date_inferred = 1)'),
        CheckConstraint('(manifestation_creation_date_uncertain = 0) OR (manifestation_creation_date_uncertain = 1)')
    )

    manifestation_id = Column(String(100), primary_key=True)
    manifestation_type = Column(String(3), nullable=False, server_default=text("''::character varying"))
    id_number_or_shelfmark = Column(String(500))
    printed_edition_details = Column(Text)
    paper_size = Column(String(500))
    paper_type_or_watermark = Column(String(500))
    number_of_pages_of_document = Column(Integer)
    number_of_pages_of_text = Column(Integer)
    seal = Column(String(500))
    postage_marks = Column(String(500))
    endorsements = Column(Text)
    non_letter_enclosures = Column(Text)
    manifestation_creation_calendar = Column(String(2), nullable=False, server_default=text("'U'::character varying"))
    manifestation_creation_date = Column(Date)
    manifestation_creation_date_gregorian = Column(Date)
    manifestation_creation_date_year = Column(Integer)
    manifestation_creation_date_month = Column(Integer)
    manifestation_creation_date_day = Column(Integer)
    manifestation_creation_date_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    manifestation_creation_date_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    manifestation_creation_date_approx = Column(SmallInteger, nullable=False, server_default=text("0"))
    manifestation_is_translation = Column(SmallInteger, nullable=False, server_default=text("0"))
    language_of_manifestation = Column(String(255))
    address = Column(Text)
    manifestation_incipit = Column(Text)
    manifestation_excipit = Column(Text)
    manifestation_ps = Column(Text)
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    creation_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    manifestation_creation_date2_year = Column(Integer)
    manifestation_creation_date2_month = Column(Integer)
    manifestation_creation_date2_day = Column(Integer)
    manifestation_creation_date_is_range = Column(SmallInteger, nullable=False, server_default=text("0"))
    manifestation_creation_date_as_marked = Column(String(250))
    opened = Column(String(3), nullable=False, server_default=text("'o'::character varying"))
    uuid = Column(UUID, server_default=text("uuid_generate_v4()"))
    routing_mark_stamp = Column(Text)
    routing_mark_ms = Column(Text)
    handling_instructions = Column(Text)
    stored_folded = Column(String(20))
    postage_costs_as_marked = Column(String(500))
    postage_costs = Column(String(500))
    non_delivery_reason = Column(String(500))
    date_of_receipt_as_marked = Column(String(500))
    manifestation_receipt_calendar = Column(String(2), nullable=False, server_default=text("'U'::character varying"))
    manifestation_receipt_date = Column(Date)
    manifestation_receipt_date_gregorian = Column(Date)
    manifestation_receipt_date_year = Column(Integer)
    manifestation_receipt_date_month = Column(Integer)
    manifestation_receipt_date_day = Column(Integer)
    manifestation_receipt_date_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    manifestation_receipt_date_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    manifestation_receipt_date_approx = Column(SmallInteger, nullable=False, server_default=text("0"))
    manifestation_receipt_date2_year = Column(Integer)
    manifestation_receipt_date2_month = Column(Integer)
    manifestation_receipt_date2_day = Column(Integer)
    manifestation_receipt_date_is_range = Column(SmallInteger, nullable=False, server_default=text("0"))
    accompaniments = Column(Text)


t_cofk_union_manifestation_selection_view = Table(
    'cofk_union_manifestation_selection_view', metadata,
    Column('relationship_id', Integer),
    Column('iwork_id', Integer),
    Column('manifestation_id', String(100)),
    Column('date_of_work_std', Date),
    Column('description', Text),
    Column('manifestation_type', String(100)),
    Column('id_number_or_shelfmark', String(500))
)


t_cofk_union_manifestation_view = Table(
    'cofk_union_manifestation_view', metadata,
    Column('relationship_id', Integer),
    Column('work_id', String(100)),
    Column('iwork_id', Integer),
    Column('date_of_work_std', Date),
    Column('description', Text),
    Column('manifestation_id', String(100)),
    Column('manifestation_type', String(100)),
    Column('id_number_or_shelfmark', String(500)),
    Column('printed_edition_details', Text)
)


t_cofk_union_modern_work_selection_view = Table(
    'cofk_union_modern_work_selection_view', metadata,
    Column('iwork_id', Integer),
    Column('work_id', String(100)),
    Column('description', Text)
)


class CofkUnionNationality(Base):
    __tablename__ = 'cofk_union_nationality'

    nationality_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_nationality_id_seq'::regclass)"))
    nationality_desc = Column(String(100), nullable=False, server_default=text("''::character varying"))


class CofkUnionOrgType(Base):
    __tablename__ = 'cofk_union_org_type'

    org_type_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_org_type_id_seq'::regclass)"))
    org_type_desc = Column(String(100), nullable=False, server_default=text("''::character varying"))


t_cofk_union_organisation_view_from_table = Table(
    'cofk_union_organisation_view_from_table', metadata,
    Column('person_id', String(100)),
    Column('foaf_name', String(200)),
    Column('skos_altlabel', Text),
    Column('skos_hiddenlabel', Text),
    Column('person_aliases', Text),
    Column('date_of_birth_year', Integer),
    Column('date_of_birth_month', Integer),
    Column('date_of_birth_day', Integer),
    Column('date_of_birth', Date),
    Column('date_of_birth_inferred', SmallInteger),
    Column('date_of_birth_uncertain', SmallInteger),
    Column('date_of_birth_approx', SmallInteger),
    Column('date_of_death_year', Integer),
    Column('date_of_death_month', Integer),
    Column('date_of_death_day', Integer),
    Column('date_of_death', Date),
    Column('date_of_death_inferred', SmallInteger),
    Column('date_of_death_uncertain', SmallInteger),
    Column('date_of_death_approx', SmallInteger),
    Column('gender', String(1)),
    Column('is_organisation', String(1)),
    Column('iperson_id', Integer),
    Column('creation_timestamp', DateTime),
    Column('creation_user', String(50)),
    Column('change_timestamp', DateTime),
    Column('change_user', String(50)),
    Column('editors_notes', Text),
    Column('further_reading', Text),
    Column('organisation_type', Integer),
    Column('date_of_birth_calendar', String(2)),
    Column('date_of_birth_is_range', SmallInteger),
    Column('date_of_birth2_year', Integer),
    Column('date_of_birth2_month', Integer),
    Column('date_of_birth2_day', Integer),
    Column('date_of_death_calendar', String(2)),
    Column('date_of_death_is_range', SmallInteger),
    Column('date_of_death2_year', Integer),
    Column('date_of_death2_month', Integer),
    Column('date_of_death2_day', Integer),
    Column('flourished', Date),
    Column('flourished_calendar', String(2)),
    Column('flourished_is_range', SmallInteger),
    Column('flourished_year', Integer),
    Column('flourished_month', Integer),
    Column('flourished_day', Integer),
    Column('flourished2_year', Integer),
    Column('flourished2_month', Integer),
    Column('flourished2_day', Integer)
)


t_cofk_union_organisation_view_from_view = Table(
    'cofk_union_organisation_view_from_view', metadata,
    Column('person_id', String(100)),
    Column('names_and_titles', Text),
    Column('date_of_birth', Date),
    Column('date_of_birth_estimated_range', SmallInteger),
    Column('date_of_birth_from', Date),
    Column('date_of_birth_to', Date),
    Column('date_of_death', Date),
    Column('date_of_death_estimated_range', SmallInteger),
    Column('date_of_death_from', Date),
    Column('date_of_death_to', Date),
    Column('flourished', Date),
    Column('flourished_estimated_range', SmallInteger),
    Column('flourished_from', Date),
    Column('flourished_to', Date),
    Column('gender', String(1)),
    Column('is_organisation', Text),
    Column('org_type', String(100)),
    Column('sent', Integer),
    Column('recd', Integer),
    Column('all_works', Integer),
    Column('mentioned', Integer),
    Column('iperson_id', Integer),
    Column('editors_notes', Text),
    Column('further_reading', Text),
    Column('images', Text),
    Column('other_details_summary', Text),
    Column('other_details_summary_searchable', Text),
    Column('change_timestamp', DateTime),
    Column('change_user', String(50))
)


t_cofk_union_person_all_works_view = Table(
    'cofk_union_person_all_works_view', metadata,
    Column('person_id', String(100)),
    Column('work_id', String(100)),
    Column('iwork_id', Integer),
    Column('description', Text)
)


t_cofk_union_person_mentioned_view = Table(
    'cofk_union_person_mentioned_view', metadata,
    Column('person_id', String(100)),
    Column('work_id', String(100)),
    Column('iwork_id', Integer),
    Column('description', Text)
)


t_cofk_union_person_recd_view = Table(
    'cofk_union_person_recd_view', metadata,
    Column('person_id', String(100)),
    Column('work_id', String(100)),
    Column('iwork_id', Integer),
    Column('description', Text)
)


t_cofk_union_person_sent_view = Table(
    'cofk_union_person_sent_view', metadata,
    Column('person_id', String(100)),
    Column('work_id', String(100)),
    Column('iwork_id', Integer),
    Column('description', Text)
)


t_cofk_union_person_view = Table(
    'cofk_union_person_view', metadata,
    Column('person_id', String(100)),
    Column('names_and_titles', Text),
    Column('date_of_birth', Date),
    Column('date_of_birth_estimated_range', SmallInteger),
    Column('date_of_birth_from', Date),
    Column('date_of_birth_to', Date),
    Column('date_of_death', Date),
    Column('date_of_death_estimated_range', SmallInteger),
    Column('date_of_death_from', Date),
    Column('date_of_death_to', Date),
    Column('flourished', Date),
    Column('flourished_estimated_range', SmallInteger),
    Column('flourished_from', Date),
    Column('flourished_to', Date),
    Column('gender', String(1)),
    Column('is_organisation', Text),
    Column('org_type', String(100)),
    Column('sent', Integer),
    Column('recd', Integer),
    Column('all_works', Integer),
    Column('mentioned', Integer),
    Column('iperson_id', Integer),
    Column('editors_notes', Text),
    Column('further_reading', Text),
    Column('images', Text),
    Column('other_details_summary', Text),
    Column('other_details_summary_searchable', Text),
    Column('change_timestamp', DateTime),
    Column('change_user', String(50))
)


class CofkUnionPublication(Base):
    __tablename__ = 'cofk_union_publication'

    publication_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_publication_id_seq'::regclass)"))
    publication_details = Column(Text, nullable=False, server_default=text("''::text"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    abbrev = Column(String(50), nullable=False, server_default=text("''::character varying"))


class CofkUnionRelationshipType(Base):
    __tablename__ = 'cofk_union_relationship_type'

    relationship_code = Column(String(50), primary_key=True)
    desc_left_to_right = Column(String(200), nullable=False, server_default=text("''::character varying"))
    desc_right_to_left = Column(String(200), nullable=False, server_default=text("''::character varying"))
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    creation_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))


class CofkUnionResource(Base):
    __tablename__ = 'cofk_union_resource'

    resource_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_resource_id_seq'::regclass)"))
    resource_name = Column(Text, nullable=False, server_default=text("''::text"))
    resource_details = Column(Text, nullable=False, server_default=text("''::text"))
    resource_url = Column(Text, nullable=False, server_default=text("''::text"))
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    creation_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    uuid = Column(UUID, server_default=text("uuid_generate_v4()"))


class CofkUnionRoleCategory(Base):
    __tablename__ = 'cofk_union_role_category'

    role_category_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_role_category_id_seq'::regclass)"))
    role_category_desc = Column(String(100), nullable=False, server_default=text("''::character varying"))


class CofkUnionSpeedEntryText(Base):
    __tablename__ = 'cofk_union_speed_entry_text'

    speed_entry_text_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_speed_entry_text_id_seq'::regclass)"))
    object_type = Column(String(30), nullable=False, server_default=text("'All'::character varying"))
    speed_entry_text = Column(String(200), nullable=False, server_default=text("''::character varying"))


class CofkUnionSubject(Base):
    __tablename__ = 'cofk_union_subject'

    subject_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_subject_id_seq'::regclass)"))
    subject_desc = Column(String(100), nullable=False, server_default=text("''::character varying"))


t_cofk_union_work_image_view = Table(
    'cofk_union_work_image_view', metadata,
    Column('description', Text),
    Column('enlarged_images', Text),
    Column('iwork_id', Integer)
)


t_cofk_union_work_selection_view = Table(
    'cofk_union_work_selection_view', metadata,
    Column('iwork_id', Integer),
    Column('work_id', String(100)),
    Column('date_of_work_std', Date),
    Column('description', Text)
)


t_cofk_union_work_view = Table(
    'cofk_union_work_view', metadata,
    Column('description', Text),
    Column('editors_notes', Text),
    Column('sender_or_recipient', Text),
    Column('place_to_or_from', Text),
    Column('date_of_work_as_marked', String(250)),
    Column('date_of_work_std_year', Integer),
    Column('date_of_work_std_month', Integer),
    Column('date_of_work_std_day', Integer),
    Column('date_of_work_std', Date),
    Column('creators_searchable', Text),
    Column('notes_on_authors', Text),
    Column('places_from_searchable', Text),
    Column('origin_as_marked', Text),
    Column('addressees_searchable', Text),
    Column('places_to_searchable', Text),
    Column('destination_as_marked', Text),
    Column('creators_for_display', Text),
    Column('places_from_for_display', Text),
    Column('addressees_for_display', Text),
    Column('places_to_for_display', Text),
    Column('flags', Text),
    Column('images', Text),
    Column('manifestations_searchable', Text),
    Column('manifestations_for_display', Text),
    Column('related_resources', Text),
    Column('language_of_work', String(255)),
    Column('subjects', Text),
    Column('abstract', Text),
    Column('people_mentioned', Text),
    Column('keywords', Text),
    Column('general_notes', Text),
    Column('original_catalogue', String(500)),
    Column('accession_code', String(1000)),
    Column('work_to_be_deleted', Text),
    Column('iwork_id', Integer),
    Column('change_timestamp', DateTime),
    Column('change_user', String(50)),
    Column('work_id', String(100))
)


class CofkUser(Base):
    __tablename__ = 'cofk_users'
    __table_args__ = (
        CheckConstraint('(active = 0) OR (active = 1)'),
        CheckConstraint("pw > ''::text")
    )

    username = Column(String(30), primary_key=True)
    pw = Column(Text, nullable=False)
    surname = Column(String(30), nullable=False, server_default=text("''::character varying"))
    forename = Column(String(30), nullable=False, server_default=text("''::character varying"))
    failed_logins = Column(Integer, nullable=False, server_default=text("0"))
    login_time = Column(DateTime)
    prev_login = Column(DateTime)
    active = Column(SmallInteger, nullable=False, server_default=text("1"))
    email = Column(Text)


t_cofk_users_and_roles_view = Table(
    'cofk_users_and_roles_view', metadata,
    Column('username', String(30)),
    Column('surname', String(30)),
    Column('forename', String(30)),
    Column('active', SmallInteger),
    Column('email', Text),
    Column('role_id', Integer),
    Column('role_code', String),
    Column('role_name', Text)
)


t_copy_cofk_union_queryable_work = Table(
    'copy_cofk_union_queryable_work', metadata,
    Column('iwork_id', Integer),
    Column('work_id', String(100)),
    Column('description', Text),
    Column('date_of_work_std', Date),
    Column('date_of_work_std_year', Integer),
    Column('date_of_work_std_month', Integer),
    Column('date_of_work_std_day', Integer),
    Column('date_of_work_as_marked', String(250)),
    Column('date_of_work_inferred', SmallInteger),
    Column('date_of_work_uncertain', SmallInteger),
    Column('date_of_work_approx', SmallInteger),
    Column('creators_searchable', Text),
    Column('creators_for_display', Text),
    Column('authors_as_marked', Text),
    Column('notes_on_authors', Text),
    Column('authors_inferred', SmallInteger),
    Column('authors_uncertain', SmallInteger),
    Column('addressees_searchable', Text),
    Column('addressees_for_display', Text),
    Column('addressees_as_marked', Text),
    Column('addressees_inferred', SmallInteger),
    Column('addressees_uncertain', SmallInteger),
    Column('places_from_searchable', Text),
    Column('places_from_for_display', Text),
    Column('origin_as_marked', Text),
    Column('origin_inferred', SmallInteger),
    Column('origin_uncertain', SmallInteger),
    Column('places_to_searchable', Text),
    Column('places_to_for_display', Text),
    Column('destination_as_marked', Text),
    Column('destination_inferred', SmallInteger),
    Column('destination_uncertain', SmallInteger),
    Column('manifestations_searchable', Text),
    Column('manifestations_for_display', Text),
    Column('abstract', Text),
    Column('keywords', Text),
    Column('people_mentioned', Text),
    Column('images', Text),
    Column('related_resources', Text),
    Column('language_of_work', String(255)),
    Column('work_is_translation', SmallInteger),
    Column('flags', Text),
    Column('edit_status', String(3)),
    Column('general_notes', Text),
    Column('original_catalogue', String(100)),
    Column('accession_code', String(1000)),
    Column('work_to_be_deleted', SmallInteger),
    Column('change_timestamp', DateTime),
    Column('change_user', String(50)),
    Column('drawer', String(50)),
    Column('editors_notes', Text),
    Column('manifestation_type', String(50)),
    Column('original_notes', Text),
    Column('relevant_to_cofk', String(1)),
    Column('subjects', Text)
)


class Iso639LanguageCode(Base):
    __tablename__ = 'iso_639_language_codes'

    code_639_3 = Column(String(3), primary_key=True, server_default=text("''::character varying"))
    code_639_1 = Column(String(2), nullable=False, server_default=text("''::character varying"))
    language_name = Column(String(100), nullable=False, server_default=text("''::character varying"))
    language_id = Column(Integer, nullable=False, server_default=text("nextval('iso_639_language_codes_id_seq'::regclass)"))


class CofkUnionFavouriteLanguage(Iso639LanguageCode):
    __tablename__ = 'cofk_union_favourite_language'

    language_code = Column(ForeignKey('iso_639_language_codes.code_639_3', ondelete='CASCADE'), primary_key=True)


class ProActivity(Base):
    __tablename__ = 'pro_activity'
    __table_args__ = {'comment': 'prosopographical activity'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('pro_id_activity'::regclass)"))
    activity_type_id = Column(Text)
    activity_name = Column(Text)
    activity_description = Column(Text)
    date_type = Column(Text)
    date_from_year = Column(Text)
    date_from_month = Column(Text)
    date_from_day = Column(Text)
    date_from_uncertainty = Column(Text)
    date_to_year = Column(Text)
    date_to_month = Column(Text)
    date_to_day = Column(Text)
    date_to_uncertainty = Column(Text)
    notes_used = Column(Text)
    additional_notes = Column(Text)
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    creation_user = Column(Text)
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(Text)
    event_label = Column(Text)


class ProActivityRelation(Base):
    __tablename__ = 'pro_activity_relation'
    __table_args__ = {'comment': 'mapping for related prosopography events'}

    id = Column(Integer, primary_key=True, server_default=text("nextval('pro_id_activity_relation'::regclass)"))
    meta_activity_id = Column(Integer)
    filename = Column(Text, nullable=False)
    spreadsheet_row = Column(Integer, nullable=False)
    combined_spreadsheet_row = Column(Integer, nullable=False)


class ProAssertion(Base):
    __tablename__ = 'pro_assertion'

    id = Column(Integer, primary_key=True, server_default=text("nextval('pro_id_assertion'::regclass)"))
    assertion_type = Column(Text)
    assertion_id = Column(Text)
    source_id = Column(Text)
    source_description = Column(Text)
    change_timestamp = Column(DateTime, server_default=text("now()"))


t_pro_ingest_map_v2 = Table(
    'pro_ingest_map_v2', metadata,
    Column('relationship', Text),
    Column('mapping', Text),
    Column('s_event_category', Text),
    Column('s_event_type', Text),
    Column('s_role', Text),
    Column('p_event_category', Text),
    Column('p_event_type', Text),
    Column('p_role', Text)
)


t_pro_ingest_v8 = Table(
    'pro_ingest_v8', metadata,
    Column('event_category', Text),
    Column('event_type', Text),
    Column('event_name', Text),
    Column('pp_i', Text),
    Column('pp_name', Text),
    Column('pp_role', Text),
    Column('sp_i', Text),
    Column('sp_name', Text),
    Column('sp_type', Text),
    Column('sp_role', Text),
    Column('df_year', Text),
    Column('df_month', Text),
    Column('df_day', Text),
    Column('df_uncertainty', Text),
    Column('dt_year', Text),
    Column('dt_month', Text),
    Column('dt_day', Text),
    Column('dt_uncertainty', Text),
    Column('date_type', Text),
    Column('location_i', Text),
    Column('location_detail', Text),
    Column('location_city', Text),
    Column('location_region', Text),
    Column('location_country', Text),
    Column('location_type', Text),
    Column('ts_abbrev', Text),
    Column('ts_detail', Text),
    Column('editor', Text),
    Column('noted_used', Text),
    Column('add_notes', Text),
    Column('filename', Text),
    Column('spreadsheet_row_id', Text),
    Column('combined_csv_row_id', Text)
)


t_pro_ingest_v8_toreview = Table(
    'pro_ingest_v8_toreview', metadata,
    Column('event_category', Text),
    Column('event_type', Text),
    Column('event_name', Text),
    Column('pp_i', Text),
    Column('pp_name', Text),
    Column('pp_role', Text),
    Column('sp_i', Text),
    Column('sp_name', Text),
    Column('sp_type', Text),
    Column('sp_role', Text),
    Column('df_year', Text),
    Column('df_month', Text),
    Column('df_day', Text),
    Column('df_uncertainty', Text),
    Column('dt_year', Text),
    Column('dt_month', Text),
    Column('dt_day', Text),
    Column('dt_uncertainty', Text),
    Column('date_type', Text),
    Column('location_i', Text),
    Column('location_detail', Text),
    Column('location_city', Text),
    Column('location_region', Text),
    Column('location_country', Text),
    Column('location_type', Text),
    Column('ts_abbrev', Text),
    Column('ts_detail', Text),
    Column('editor', Text),
    Column('noted_used', Text),
    Column('add_notes', Text),
    Column('filename', Text),
    Column('spreadsheet_row_id', Text),
    Column('combined_csv_row_id', Text)
)


class ProLocation(Base):
    __tablename__ = 'pro_location'

    id = Column(Integer, primary_key=True, server_default=text("nextval('pro_id_location'::regclass)"))
    location_id = Column(Text)
    change_timestamp = Column(DateTime, server_default=text("now()"))
    activity_id = Column(Integer)


t_pro_people_check = Table(
    'pro_people_check', metadata,
    Column('person_name', Text),
    Column('iperson_id', Text)
)


class ProPrimaryPerson(Base):
    __tablename__ = 'pro_primary_person'

    id = Column(Integer, primary_key=True, server_default=text("nextval('pro_id_primary_person'::regclass)"))
    person_id = Column(Text)
    change_timestamp = Column(DateTime, server_default=text("now()"))
    activity_id = Column(Integer)


class ProRelationship(Base):
    __tablename__ = 'pro_relationship'

    id = Column(Integer, primary_key=True, server_default=text("nextval('pro_id_relationship'::regclass)"))
    subject_id = Column(Text)
    subject_type = Column(Text)
    subject_role_id = Column(Text)
    relationship_id = Column(Text)
    object_id = Column(Text)
    object_type = Column(Text)
    object_role_id = Column(Text)
    change_timestamp = Column(DateTime, server_default=text("now()"))
    activity_id = Column(Integer)


class ProRoleInActivity(Base):
    __tablename__ = 'pro_role_in_activity'

    id = Column(Integer, primary_key=True, server_default=text("nextval('pro_id_role_in_activity'::regclass)"))
    entity_type = Column(Text)
    entity_id = Column(Text)
    role_id = Column(Text)
    change_timestamp = Column(DateTime, server_default=text("now()"))
    activity_id = Column(Integer)


class ProTextualSource(Base):
    __tablename__ = 'pro_textual_source'

    id = Column(Integer, primary_key=True, server_default=text("nextval('pro_id_textual_source'::regclass)"))
    author = Column(Text)
    title = Column(Text)
    chapterArticleTitle = Column(Text)
    volumeSeriesNumber = Column(Text)
    issueNumber = Column(Text)
    pageNumber = Column(Text)
    editor = Column(Text)
    placePublication = Column(Text)
    datePublication = Column(Text)
    urlResource = Column(Text)
    abbreviation = Column(Text)
    fullBibliographicDetails = Column(Text)
    edition = Column(Text)
    reprintFacsimile = Column(Text)
    repository = Column(Text)
    creation_user = Column(Text)
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(Text)
    change_timestamp = Column(DateTime, server_default=text("now()"))


class CofkCollectToolSession(Base):
    __tablename__ = 'cofk_collect_tool_session'

    session_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_sessions_session_id_seq'::regclass)"))
    session_timestamp = Column(DateTime, nullable=False, server_default=text("now()"))
    session_code = Column(Text, unique=True)
    username = Column(ForeignKey('cofk_collect_tool_user.tool_user_email', ondelete='CASCADE', onupdate='CASCADE'))

    cofk_collect_tool_user = relationship('CofkCollectToolUser')


class CofkCollectUpload(Base):
    __tablename__ = 'cofk_collect_upload'

    upload_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_collect_upload_id_seq'::regclass)"))
    upload_username = Column(String(100), nullable=False)
    upload_description = Column(Text)
    upload_status = Column(ForeignKey('cofk_collect_status.status_id'), nullable=False, server_default=text("1"))
    upload_timestamp = Column(DateTime, nullable=False, server_default=text("now()"))
    total_works = Column(Integer, nullable=False, server_default=text("0"))
    works_accepted = Column(Integer, nullable=False, server_default=text("0"))
    works_rejected = Column(Integer, nullable=False, server_default=text("0"))
    uploader_email = Column(String(250), nullable=False, server_default=text("''::character varying"))
    _id = Column(String(32))
    upload_name = Column(String(254))

    cofk_collect_statu = relationship('CofkCollectStatu')


class CofkHelpOption(Base):
    __tablename__ = 'cofk_help_options'
    __table_args__ = (
        UniqueConstraint('menu_item_id', 'button_name'),
    )

    option_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_help_options_option_id_seq'::regclass)"))
    menu_item_id = Column(ForeignKey('cofk_menu.menu_item_id'))
    button_name = Column(String(100), nullable=False, server_default=text("''::character varying"))
    help_page_id = Column(ForeignKey('cofk_help_pages.page_id'), nullable=False)
    order_in_manual = Column(Integer, nullable=False, server_default=text("0"))
    menu_depth = Column(Integer, nullable=False, server_default=text("0"))

    help_page = relationship('CofkHelpPage')
    menu_item = relationship('CofkMenu')


class CofkReport(Base):
    __tablename__ = 'cofk_reports'

    report_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_reports_report_id_seq'::regclass)"))
    report_title = Column(Text)
    class_name = Column(String(40))
    method_name = Column(String(40))
    report_group_id = Column(ForeignKey('cofk_report_groups.report_group_id'))
    menu_item_id = Column(ForeignKey('cofk_menu.menu_item_id'))
    has_csv_option = Column(Integer, nullable=False, server_default=text("0"))
    is_dummy_option = Column(Integer, nullable=False, server_default=text("0"))
    report_code = Column(String(100))
    parm_list = Column(Text)
    parm_titles = Column(Text)
    prompt_for_parms = Column(SmallInteger, nullable=False, server_default=text("0"))
    default_parm_values = Column(Text)
    parm_methods = Column(Text)
    report_help = Column(Text)

    menu_item = relationship('CofkMenu')
    report_group = relationship('CofkReportGroup')


class CofkSession(Base):
    __tablename__ = 'cofk_sessions'

    session_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_sessions_session_id_seq'::regclass)"))
    session_timestamp = Column(DateTime, nullable=False, server_default=text("now()"))
    session_code = Column(Text, unique=True)
    username = Column(ForeignKey('cofk_users.username'))

    cofk_user = relationship('CofkUser')


class CofkUnionLanguageOfManifestation(Base):
    __tablename__ = 'cofk_union_language_of_manifestation'

    manifestation_id = Column(ForeignKey('cofk_union_manifestation.manifestation_id', ondelete='CASCADE'), primary_key=True, nullable=False)
    language_code = Column(ForeignKey('iso_639_language_codes.code_639_3', ondelete='CASCADE'), primary_key=True, nullable=False)
    notes = Column(String(100))

    iso_639_language_code = relationship('Iso639LanguageCode')
    manifestation = relationship('CofkUnionManifestation')


class CofkUnionPerson(Base):
    __tablename__ = 'cofk_union_person'
    __table_args__ = (
        CheckConstraint('(date_of_birth_approx = 0) OR (date_of_birth_approx = 1)'),
        CheckConstraint('(date_of_birth_inferred = 0) OR (date_of_birth_inferred = 1)'),
        CheckConstraint('(date_of_birth_is_range = 0) OR (date_of_birth_is_range = 1)'),
        CheckConstraint('(date_of_birth_uncertain = 0) OR (date_of_birth_uncertain = 1)'),
        CheckConstraint('(date_of_death_approx = 0) OR (date_of_death_approx = 1)'),
        CheckConstraint('(date_of_death_inferred = 0) OR (date_of_death_inferred = 1)'),
        CheckConstraint('(date_of_death_is_range = 0) OR (date_of_death_is_range = 1)'),
        CheckConstraint('(date_of_death_uncertain = 0) OR (date_of_death_uncertain = 1)'),
        CheckConstraint('(flourished_is_range = 0) OR (flourished_is_range = 1)')
    )

    person_id = Column(String(100), primary_key=True)
    foaf_name = Column(String(200), nullable=False)
    skos_altlabel = Column(Text)
    skos_hiddenlabel = Column(Text)
    person_aliases = Column(Text)
    date_of_birth_year = Column(Integer)
    date_of_birth_month = Column(Integer)
    date_of_birth_day = Column(Integer)
    date_of_birth = Column(Date)
    date_of_birth_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_birth_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_birth_approx = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_death_year = Column(Integer)
    date_of_death_month = Column(Integer)
    date_of_death_day = Column(Integer)
    date_of_death = Column(Date)
    date_of_death_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_death_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_death_approx = Column(SmallInteger, nullable=False, server_default=text("0"))
    gender = Column(String(1), nullable=False, server_default=text("''::character varying"))
    is_organisation = Column(String(1), nullable=False, server_default=text("''::character varying"))
    iperson_id = Column(Integer, nullable=False, unique=True, server_default=text("nextval('cofk_union_person_iperson_id_seq'::regclass)"))
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    creation_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    editors_notes = Column(Text)
    further_reading = Column(Text)
    organisation_type = Column(ForeignKey('cofk_union_org_type.org_type_id'))
    date_of_birth_calendar = Column(String(2), nullable=False, server_default=text("''::character varying"))
    date_of_birth_is_range = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_birth2_year = Column(Integer)
    date_of_birth2_month = Column(Integer)
    date_of_birth2_day = Column(Integer)
    date_of_death_calendar = Column(String(2), nullable=False, server_default=text("''::character varying"))
    date_of_death_is_range = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_death2_year = Column(Integer)
    date_of_death2_month = Column(Integer)
    date_of_death2_day = Column(Integer)
    flourished = Column(Date)
    flourished_calendar = Column(String(2), nullable=False, server_default=text("''::character varying"))
    flourished_is_range = Column(SmallInteger, nullable=False, server_default=text("0"))
    flourished_year = Column(Integer)
    flourished_month = Column(Integer)
    flourished_day = Column(Integer)
    flourished2_year = Column(Integer)
    flourished2_month = Column(Integer)
    flourished2_day = Column(Integer)
    uuid = Column(UUID, server_default=text("uuid_generate_v4()"))
    flourished_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    flourished_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    flourished_approx = Column(SmallInteger, nullable=False, server_default=text("0"))

    cofk_union_org_type = relationship('CofkUnionOrgType')


class CofkUnionPersonSummary(CofkUnionPerson):
    __tablename__ = 'cofk_union_person_summary'

    iperson_id = Column(ForeignKey('cofk_union_person.iperson_id', ondelete='CASCADE'), primary_key=True)
    other_details_summary = Column(Text)
    other_details_summary_searchable = Column(Text)
    sent = Column(Integer, nullable=False, server_default=text("0"))
    recd = Column(Integer, nullable=False, server_default=text("0"))
    all_works = Column(Integer, nullable=False, server_default=text("0"))
    mentioned = Column(Integer, nullable=False, server_default=text("0"))
    role_categories = Column(Text)
    images = Column(Text)


class CofkUnionRelationship(Base):
    __tablename__ = 'cofk_union_relationship'
    __table_args__ = (
        Index('cofk_union_relationship_right_idx', 'right_table_name', 'right_id_value', 'relationship_type'),
        Index('cofk_union_relationship_left_idx', 'left_table_name', 'left_id_value', 'relationship_type')
    )

    relationship_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_union_relationship_id_seq'::regclass)"))
    left_table_name = Column(String(100), nullable=False)
    left_id_value = Column(String(100), nullable=False)
    relationship_type = Column(ForeignKey('cofk_union_relationship_type.relationship_code'), nullable=False)
    right_table_name = Column(String(100), nullable=False)
    right_id_value = Column(String(100), nullable=False)
    relationship_valid_from = Column(DateTime)
    relationship_valid_till = Column(DateTime)
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    creation_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))

    cofk_union_relationship_type = relationship('CofkUnionRelationshipType')


class CofkUnionWork(Base):
    __tablename__ = 'cofk_union_work'
    __table_args__ = (
        CheckConstraint('(addressees_inferred = 0) OR (addressees_inferred = 1)'),
        CheckConstraint('(addressees_uncertain = 0) OR (addressees_uncertain = 1)'),
        CheckConstraint('(authors_inferred = 0) OR (authors_inferred = 1)'),
        CheckConstraint('(authors_uncertain = 0) OR (authors_uncertain = 1)'),
        CheckConstraint('(date_of_work_approx = 0) OR (date_of_work_approx = 1)'),
        CheckConstraint('(date_of_work_inferred = 0) OR (date_of_work_inferred = 1)'),
        CheckConstraint('(date_of_work_std_is_range = 0) OR (date_of_work_std_is_range = 1)'),
        CheckConstraint('(date_of_work_uncertain = 0) OR (date_of_work_uncertain = 1)'),
        CheckConstraint('(destination_inferred = 0) OR (destination_inferred = 1)'),
        CheckConstraint('(destination_uncertain = 0) OR (destination_uncertain = 1)'),
        CheckConstraint('(origin_inferred = 0) OR (origin_inferred = 1)'),
        CheckConstraint('(origin_uncertain = 0) OR (origin_uncertain = 1)'),
        CheckConstraint('(work_is_translation = 0) OR (work_is_translation = 1)'),
        CheckConstraint('(work_to_be_deleted = 0) OR (work_to_be_deleted = 1)')
    )

    work_id = Column(String(100), primary_key=True)
    description = Column(Text)
    date_of_work_as_marked = Column(String(250))
    original_calendar = Column(String(2), nullable=False, server_default=text("''::character varying"))
    date_of_work_std = Column(String(12), server_default=text("'9999-12-31'::character varying"))
    date_of_work_std_gregorian = Column(String(12), server_default=text("'9999-12-31'::character varying"))
    date_of_work_std_year = Column(Integer)
    date_of_work_std_month = Column(Integer)
    date_of_work_std_day = Column(Integer)
    date_of_work2_std_year = Column(Integer)
    date_of_work2_std_month = Column(Integer)
    date_of_work2_std_day = Column(Integer)
    date_of_work_std_is_range = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_work_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_work_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_work_approx = Column(SmallInteger, nullable=False, server_default=text("0"))
    authors_as_marked = Column(Text)
    addressees_as_marked = Column(Text)
    authors_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    authors_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    addressees_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    addressees_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    destination_as_marked = Column(Text)
    origin_as_marked = Column(Text)
    destination_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    destination_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    origin_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    origin_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    abstract = Column(Text)
    keywords = Column(Text)
    language_of_work = Column(String(255))
    work_is_translation = Column(SmallInteger, nullable=False, server_default=text("0"))
    incipit = Column(Text)
    explicit = Column(Text)
    ps = Column(Text)
    original_catalogue = Column(ForeignKey('cofk_lookup_catalogue.catalogue_code', onupdate='CASCADE'), nullable=False, server_default=text("''::character varying"))
    accession_code = Column(String(1000))
    work_to_be_deleted = Column(SmallInteger, nullable=False, server_default=text("0"))
    iwork_id = Column(Integer, nullable=False, unique=True, server_default=text("nextval('cofk_union_work_iwork_id_seq'::regclass)"))
    editors_notes = Column(Text)
    edit_status = Column(String(3), nullable=False, server_default=text("''::character varying"))
    relevant_to_cofk = Column(String(3), nullable=False, server_default=text("'Y'::character varying"))
    creation_timestamp = Column(DateTime, server_default=text("now()"))
    creation_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    uuid = Column(UUID, server_default=text("uuid_generate_v4()"))

    cofk_lookup_catalogue = relationship('CofkLookupCatalogue')


t_cofk_user_roles = Table(
    'cofk_user_roles', metadata,
    Column('username', ForeignKey('cofk_users.username'), primary_key=True, nullable=False),
    Column('role_id', ForeignKey('cofk_roles.role_id'), primary_key=True, nullable=False)
)


class CofkUserSavedQuery(Base):
    __tablename__ = 'cofk_user_saved_queries'

    query_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_user_saved_queries_id_seq'::regclass)"))
    username = Column(ForeignKey('cofk_users.username'), nullable=False, server_default=text("\"current_user\"()"))
    query_class = Column(String(100), nullable=False)
    query_method = Column(String(100), nullable=False)
    query_title = Column(Text, nullable=False, server_default=text("''::text"))
    query_order_by = Column(String(100), nullable=False, server_default=text("''::character varying"))
    query_sort_descending = Column(SmallInteger, nullable=False, server_default=text("0"))
    query_entries_per_page = Column(SmallInteger, nullable=False, server_default=text("20"))
    query_record_layout = Column(String(12), nullable=False, server_default=text("'across_page'::character varying"))
    query_menu_item_name = Column(Text)
    creation_timestamp = Column(DateTime, server_default=text("now()"))

    cofk_user = relationship('CofkUser')


class CofkCollectInstitution(Base):
    __tablename__ = 'cofk_collect_institution'

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    institution_id = Column(Integer, primary_key=True, nullable=False)
    union_institution_id = Column(ForeignKey('cofk_union_institution.institution_id', ondelete='SET NULL'))
    institution_name = Column(Text, nullable=False, server_default=text("''::text"))
    institution_city = Column(Text, nullable=False, server_default=text("''::text"))
    institution_country = Column(Text, nullable=False, server_default=text("''::text"))
    upload_name = Column(String(254))
    _id = Column(String(32))
    institution_synonyms = Column(Text)
    institution_city_synonyms = Column(Text)
    institution_country_synonyms = Column(Text)

    union_institution = relationship('CofkUnionInstitution')
    upload = relationship('CofkCollectUpload')


class CofkCollectLocation(Base):
    __tablename__ = 'cofk_collect_location'

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    location_id = Column(Integer, primary_key=True, nullable=False)
    union_location_id = Column(ForeignKey('cofk_union_location.location_id', ondelete='SET NULL'))
    location_name = Column(String(500), nullable=False, server_default=text("''::character varying"))
    element_1_eg_room = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_2_eg_building = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_3_eg_parish = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_4_eg_city = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_5_eg_county = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_6_eg_country = Column(String(100), nullable=False, server_default=text("''::character varying"))
    element_7_eg_empire = Column(String(100), nullable=False, server_default=text("''::character varying"))
    notes_on_place = Column(Text)
    editors_notes = Column(Text)
    upload_name = Column(String(254))
    _id = Column(String(32))
    location_synonyms = Column(Text)
    latitude = Column(String(20))
    longitude = Column(String(20))

    union_location = relationship('CofkUnionLocation')
    upload = relationship('CofkCollectUpload')


class CofkCollectPerson(Base):
    __tablename__ = 'cofk_collect_person'

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    iperson_id = Column(Integer, primary_key=True, nullable=False)
    union_iperson_id = Column(ForeignKey('cofk_union_person.iperson_id', ondelete='SET NULL'))
    person_id = Column(ForeignKey('cofk_union_person.person_id', ondelete='SET NULL'))
    primary_name = Column(String(200), nullable=False)
    alternative_names = Column(Text)
    roles_or_titles = Column(Text)
    gender = Column(String(1), nullable=False, server_default=text("''::character varying"))
    is_organisation = Column(String(1), nullable=False, server_default=text("''::character varying"))
    organisation_type = Column(Integer)
    date_of_birth_year = Column(Integer)
    date_of_birth_month = Column(Integer)
    date_of_birth_day = Column(Integer)
    date_of_birth_is_range = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_birth2_year = Column(Integer)
    date_of_birth2_month = Column(Integer)
    date_of_birth2_day = Column(Integer)
    date_of_birth_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_birth_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_birth_approx = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_death_year = Column(Integer)
    date_of_death_month = Column(Integer)
    date_of_death_day = Column(Integer)
    date_of_death_is_range = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_death2_year = Column(Integer)
    date_of_death2_month = Column(Integer)
    date_of_death2_day = Column(Integer)
    date_of_death_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_death_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_death_approx = Column(SmallInteger, nullable=False, server_default=text("0"))
    flourished_year = Column(Integer)
    flourished_month = Column(Integer)
    flourished_day = Column(Integer)
    flourished_is_range = Column(SmallInteger, nullable=False, server_default=text("0"))
    flourished2_year = Column(Integer)
    flourished2_month = Column(Integer)
    flourished2_day = Column(Integer)
    notes_on_person = Column(Text)
    editors_notes = Column(Text)
    upload_name = Column(String(254))
    _id = Column(String(32))

    person = relationship('CofkUnionPerson', primaryjoin='CofkCollectPerson.person_id == CofkUnionPerson.person_id')
    union_iperson = relationship('CofkUnionPerson', primaryjoin='CofkCollectPerson.union_iperson_id == CofkUnionPerson.iperson_id')
    upload = relationship('CofkCollectUpload')


class CofkUnionLanguageOfWork(Base):
    __tablename__ = 'cofk_union_language_of_work'

    work_id = Column(ForeignKey('cofk_union_work.work_id', ondelete='CASCADE'), primary_key=True, nullable=False)
    language_code = Column(ForeignKey('iso_639_language_codes.code_639_3', ondelete='CASCADE'), primary_key=True, nullable=False)
    notes = Column(String(100))

    iso_639_language_code = relationship('Iso639LanguageCode')
    work = relationship('CofkUnionWork')


class CofkUnionQueryableWork(Base):
    __tablename__ = 'cofk_union_queryable_work'

    iwork_id = Column(Integer, primary_key=True)
    work_id = Column(ForeignKey('cofk_union_work.work_id', ondelete='CASCADE'), nullable=False, unique=True)
    description = Column(Text)
    date_of_work_std = Column(Date)
    date_of_work_std_year = Column(Integer)
    date_of_work_std_month = Column(Integer)
    date_of_work_std_day = Column(Integer)
    date_of_work_as_marked = Column(String(250))
    date_of_work_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_work_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_work_approx = Column(SmallInteger, nullable=False, server_default=text("0"))
    creators_searchable = Column(Text, nullable=False, server_default=text("''::text"))
    creators_for_display = Column(Text, nullable=False, server_default=text("''::text"))
    authors_as_marked = Column(Text)
    notes_on_authors = Column(Text)
    authors_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    authors_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    addressees_searchable = Column(Text, nullable=False, server_default=text("''::text"))
    addressees_for_display = Column(Text, nullable=False, server_default=text("''::text"))
    addressees_as_marked = Column(Text)
    addressees_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    addressees_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    places_from_searchable = Column(Text, nullable=False, server_default=text("''::text"))
    places_from_for_display = Column(Text, nullable=False, server_default=text("''::text"))
    origin_as_marked = Column(Text)
    origin_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    origin_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    places_to_searchable = Column(Text, nullable=False, server_default=text("''::text"))
    places_to_for_display = Column(Text, nullable=False, server_default=text("''::text"))
    destination_as_marked = Column(Text)
    destination_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    destination_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    manifestations_searchable = Column(Text, nullable=False, server_default=text("''::text"))
    manifestations_for_display = Column(Text, nullable=False, server_default=text("''::text"))
    abstract = Column(Text)
    keywords = Column(Text)
    people_mentioned = Column(Text)
    images = Column(Text)
    related_resources = Column(Text)
    language_of_work = Column(String(255))
    work_is_translation = Column(SmallInteger, nullable=False, server_default=text("0"))
    flags = Column(Text)
    edit_status = Column(String(3), nullable=False, server_default=text("''::character varying"))
    general_notes = Column(Text)
    original_catalogue = Column(String(100), nullable=False, server_default=text("''::character varying"))
    accession_code = Column(String(1000))
    work_to_be_deleted = Column(SmallInteger, nullable=False, server_default=text("0"))
    change_timestamp = Column(DateTime, server_default=text("now()"))
    change_user = Column(String(50), nullable=False, server_default=text("\"current_user\"()"))
    drawer = Column(String(50))
    editors_notes = Column(Text)
    manifestation_type = Column(String(50))
    original_notes = Column(Text)
    relevant_to_cofk = Column(String(1), nullable=False, server_default=text("''::character varying"))
    subjects = Column(Text)

    work = relationship('CofkUnionWork', uselist=False)


class CofkUserSavedQuerySelection(Base):
    __tablename__ = 'cofk_user_saved_query_selection'

    selection_id = Column(Integer, primary_key=True, server_default=text("nextval('cofk_user_saved_query_selection_id_seq'::regclass)"))
    query_id = Column(ForeignKey('cofk_user_saved_queries.query_id'), nullable=False)
    column_name = Column(String(100), nullable=False)
    column_value = Column(String(500), nullable=False)
    op_name = Column(String(100), nullable=False)
    op_value = Column(String(100), nullable=False)
    column_value2 = Column(String(500), nullable=False, server_default=text("''::character varying"))

    query = relationship('CofkUserSavedQuery')


class CofkCollectInstitutionResource(Base):
    __tablename__ = 'cofk_collect_institution_resource'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'institution_id'], ['cofk_collect_institution.upload_id', 'cofk_collect_institution.institution_id']),
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    resource_id = Column(Integer, primary_key=True, nullable=False)
    institution_id = Column(Integer, nullable=False)
    resource_name = Column(Text, nullable=False, server_default=text("''::text"))
    resource_details = Column(Text, nullable=False, server_default=text("''::text"))
    resource_url = Column(Text, nullable=False, server_default=text("''::text"))

    upload = relationship('CofkCollectInstitution')
    upload1 = relationship('CofkCollectUpload')


class CofkCollectLocationResource(Base):
    __tablename__ = 'cofk_collect_location_resource'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'location_id'], ['cofk_collect_location.upload_id', 'cofk_collect_location.location_id']),
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    resource_id = Column(Integer, primary_key=True, nullable=False)
    location_id = Column(Integer, nullable=False)
    resource_name = Column(Text, nullable=False, server_default=text("''::text"))
    resource_details = Column(Text, nullable=False, server_default=text("''::text"))
    resource_url = Column(Text, nullable=False, server_default=text("''::text"))

    upload = relationship('CofkCollectLocation')
    upload1 = relationship('CofkCollectUpload')


class CofkCollectOccupationOfPerson(Base):
    __tablename__ = 'cofk_collect_occupation_of_person'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iperson_id'], ['cofk_collect_person.upload_id', 'cofk_collect_person.iperson_id']),
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    occupation_of_person_id = Column(Integer, primary_key=True, nullable=False)
    iperson_id = Column(Integer, nullable=False)
    occupation_id = Column(ForeignKey('cofk_union_role_category.role_category_id', ondelete='CASCADE'), nullable=False)

    occupation = relationship('CofkUnionRoleCategory')
    upload = relationship('CofkCollectPerson')
    upload1 = relationship('CofkCollectUpload')


class CofkCollectPersonResource(Base):
    __tablename__ = 'cofk_collect_person_resource'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iperson_id'], ['cofk_collect_person.upload_id', 'cofk_collect_person.iperson_id']),
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    resource_id = Column(Integer, primary_key=True, nullable=False)
    iperson_id = Column(Integer, nullable=False)
    resource_name = Column(Text, nullable=False, server_default=text("''::text"))
    resource_details = Column(Text, nullable=False, server_default=text("''::text"))
    resource_url = Column(Text, nullable=False, server_default=text("''::text"))

    upload = relationship('CofkCollectPerson')
    upload1 = relationship('CofkCollectUpload')


class CofkCollectWork(Base):
    __tablename__ = 'cofk_collect_work'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'destination_id'], ['cofk_collect_location.upload_id', 'cofk_collect_location.location_id']),
        ForeignKeyConstraint(['upload_id', 'origin_id'], ['cofk_collect_location.upload_id', 'cofk_collect_location.location_id'])
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    iwork_id = Column(Integer, primary_key=True, nullable=False)
    union_iwork_id = Column(ForeignKey('cofk_union_work.iwork_id', ondelete='SET NULL'))
    work_id = Column(ForeignKey('cofk_union_work.work_id', ondelete='SET NULL'))
    date_of_work_as_marked = Column(String(250))
    original_calendar = Column(String(2), nullable=False, server_default=text("''::character varying"))
    date_of_work_std_year = Column(Integer)
    date_of_work_std_month = Column(Integer)
    date_of_work_std_day = Column(Integer)
    date_of_work2_std_year = Column(Integer)
    date_of_work2_std_month = Column(Integer)
    date_of_work2_std_day = Column(Integer)
    date_of_work_std_is_range = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_work_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_work_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_work_approx = Column(SmallInteger, nullable=False, server_default=text("0"))
    notes_on_date_of_work = Column(Text)
    authors_as_marked = Column(Text)
    authors_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    authors_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    notes_on_authors = Column(Text)
    addressees_as_marked = Column(Text)
    addressees_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    addressees_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    notes_on_addressees = Column(Text)
    destination_id = Column(Integer)
    destination_as_marked = Column(Text)
    destination_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    destination_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    origin_id = Column(Integer)
    origin_as_marked = Column(Text)
    origin_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    origin_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    abstract = Column(Text)
    keywords = Column(Text)
    language_of_work = Column(String(255))
    incipit = Column(Text)
    excipit = Column(Text)
    accession_code = Column(String(250))
    notes_on_letter = Column(Text)
    notes_on_people_mentioned = Column(Text)
    upload_status = Column(ForeignKey('cofk_collect_status.status_id'), nullable=False, server_default=text("1"))
    editors_notes = Column(Text)
    _id = Column(String(32))
    date_of_work2_approx = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_work2_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    date_of_work2_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    mentioned_as_marked = Column(Text)
    mentioned_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    mentioned_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    notes_on_destination = Column(Text)
    notes_on_origin = Column(Text)
    notes_on_place_mentioned = Column(Text)
    place_mentioned_as_marked = Column(Text)
    place_mentioned_inferred = Column(SmallInteger, nullable=False, server_default=text("0"))
    place_mentioned_uncertain = Column(SmallInteger, nullable=False, server_default=text("0"))
    upload_name = Column(String(254))
    explicit = Column(Text)

    union_iwork = relationship('CofkUnionWork', primaryjoin='CofkCollectWork.union_iwork_id == CofkUnionWork.iwork_id')
    upload = relationship('CofkCollectLocation', primaryjoin='CofkCollectWork.upload_id == CofkCollectLocation.upload_id')
    upload1 = relationship('CofkCollectLocation', primaryjoin='CofkCollectWork.upload_id == CofkCollectLocation.upload_id')
    upload2 = relationship('CofkCollectUpload')
    cofk_collect_statu = relationship('CofkCollectStatu')
    work = relationship('CofkUnionWork', primaryjoin='CofkCollectWork.work_id == CofkUnionWork.work_id')


class CofkCollectWorkSummary(CofkCollectWork):
    __tablename__ = 'cofk_collect_work_summary'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'work_id_in_tool'], ['cofk_collect_work.upload_id', 'cofk_collect_work.iwork_id']),
    )

    upload_id = Column(Integer, primary_key=True, nullable=False)
    work_id_in_tool = Column(Integer, primary_key=True, nullable=False)
    source_of_data = Column(String(250))
    notes_on_letter = Column(Text)
    date_of_work = Column(String(32))
    date_of_work_as_marked = Column(String(250))
    original_calendar = Column(String(30))
    date_of_work_is_range = Column(String(30))
    date_of_work_inferred = Column(String(30))
    date_of_work_uncertain = Column(String(30))
    date_of_work_approx = Column(String(30))
    notes_on_date_of_work = Column(Text)
    authors = Column(Text)
    authors_as_marked = Column(Text)
    authors_inferred = Column(String(30))
    authors_uncertain = Column(String(30))
    notes_on_authors = Column(Text)
    addressees = Column(Text)
    addressees_as_marked = Column(Text)
    addressees_inferred = Column(String(30))
    addressees_uncertain = Column(String(30))
    notes_on_addressees = Column(Text)
    destination = Column(Text)
    destination_as_marked = Column(Text)
    destination_inferred = Column(String(30))
    destination_uncertain = Column(String(30))
    origin = Column(Text)
    origin_as_marked = Column(Text)
    origin_inferred = Column(String(30))
    origin_uncertain = Column(String(30))
    abstract = Column(Text)
    keywords = Column(Text)
    languages_of_work = Column(Text)
    subjects_of_work = Column(Text)
    incipit = Column(Text)
    excipit = Column(Text)
    people_mentioned = Column(Text)
    notes_on_people_mentioned = Column(Text)
    places_mentioned = Column(Text)
    manifestations = Column(Text)
    related_resources = Column(Text)
    editors_notes = Column(Text)


class CofkCollectAddresseeOfWork(Base):
    __tablename__ = 'cofk_collect_addressee_of_work'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iperson_id'], ['cofk_collect_person.upload_id', 'cofk_collect_person.iperson_id']),
        ForeignKeyConstraint(['upload_id', 'iwork_id'], ['cofk_collect_work.upload_id', 'cofk_collect_work.iwork_id'])
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    addressee_id = Column(Integer, primary_key=True, nullable=False)
    iperson_id = Column(Integer, nullable=False)
    iwork_id = Column(Integer, primary_key=True, nullable=False)
    notes_on_addressee = Column(Text)
    _id = Column(String(32))

    upload = relationship('CofkCollectPerson')
    upload1 = relationship('CofkCollectWork')
    upload2 = relationship('CofkCollectUpload')


class CofkCollectAuthorOfWork(Base):
    __tablename__ = 'cofk_collect_author_of_work'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iperson_id'], ['cofk_collect_person.upload_id', 'cofk_collect_person.iperson_id']),
        ForeignKeyConstraint(['upload_id', 'iwork_id'], ['cofk_collect_work.upload_id', 'cofk_collect_work.iwork_id'])
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    author_id = Column(Integer, primary_key=True, nullable=False)
    iperson_id = Column(Integer, nullable=False)
    iwork_id = Column(Integer, primary_key=True, nullable=False)
    notes_on_author = Column(Text)
    _id = Column(String(32))

    upload = relationship('CofkCollectPerson')
    upload1 = relationship('CofkCollectWork')
    upload2 = relationship('CofkCollectUpload')


class CofkCollectDestinationOfWork(Base):
    __tablename__ = 'cofk_collect_destination_of_work'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iwork_id'], ['cofk_collect_work.upload_id', 'cofk_collect_work.iwork_id']),
        ForeignKeyConstraint(['upload_id', 'location_id'], ['cofk_collect_location.upload_id', 'cofk_collect_location.location_id'])
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    destination_id = Column(Integer, primary_key=True, nullable=False)
    location_id = Column(Integer, nullable=False)
    iwork_id = Column(Integer, primary_key=True, nullable=False)
    notes_on_destination = Column(Text)
    _id = Column(String(32))

    upload = relationship('CofkCollectWork')
    upload1 = relationship('CofkCollectLocation')
    upload2 = relationship('CofkCollectUpload')


class CofkCollectLanguageOfWork(Base):
    __tablename__ = 'cofk_collect_language_of_work'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iwork_id'], ['cofk_collect_work.upload_id', 'cofk_collect_work.iwork_id']),
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    language_of_work_id = Column(Integer, primary_key=True, nullable=False)
    iwork_id = Column(Integer, primary_key=True, nullable=False)
    language_code = Column(ForeignKey('iso_639_language_codes.code_639_3'), nullable=False)
    _id = Column(String(32))

    iso_639_language_code = relationship('Iso639LanguageCode')
    upload = relationship('CofkCollectWork')
    upload1 = relationship('CofkCollectUpload')


class CofkCollectManifestation(Base):
    __tablename__ = 'cofk_collect_manifestation'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iwork_id'], ['cofk_collect_work.upload_id', 'cofk_collect_work.iwork_id']),
        ForeignKeyConstraint(['upload_id', 'repository_id'], ['cofk_collect_institution.upload_id', 'cofk_collect_institution.institution_id'])
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    manifestation_id = Column(Integer, primary_key=True, nullable=False)
    iwork_id = Column(Integer, primary_key=True, nullable=False)
    union_manifestation_id = Column(ForeignKey('cofk_union_manifestation.manifestation_id', ondelete='SET NULL'))
    manifestation_type = Column(String(3), nullable=False, server_default=text("''::character varying"))
    repository_id = Column(Integer)
    id_number_or_shelfmark = Column(String(500))
    printed_edition_details = Column(Text)
    manifestation_notes = Column(Text)
    image_filenames = Column(Text)
    upload_name = Column(String(254))
    _id = Column(String(32))

    union_manifestation = relationship('CofkUnionManifestation')
    upload = relationship('CofkCollectWork')
    upload1 = relationship('CofkCollectInstitution')
    upload2 = relationship('CofkCollectUpload')


class CofkCollectOriginOfWork(Base):
    __tablename__ = 'cofk_collect_origin_of_work'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iwork_id'], ['cofk_collect_work.upload_id', 'cofk_collect_work.iwork_id']),
        ForeignKeyConstraint(['upload_id', 'location_id'], ['cofk_collect_location.upload_id', 'cofk_collect_location.location_id'])
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    origin_id = Column(Integer, primary_key=True, nullable=False)
    location_id = Column(Integer, nullable=False)
    iwork_id = Column(Integer, primary_key=True, nullable=False)
    notes_on_origin = Column(Text)
    _id = Column(String(32))

    upload = relationship('CofkCollectWork')
    upload1 = relationship('CofkCollectLocation')
    upload2 = relationship('CofkCollectUpload')


class CofkCollectPersonMentionedInWork(Base):
    __tablename__ = 'cofk_collect_person_mentioned_in_work'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iperson_id'], ['cofk_collect_person.upload_id', 'cofk_collect_person.iperson_id']),
        ForeignKeyConstraint(['upload_id', 'iwork_id'], ['cofk_collect_work.upload_id', 'cofk_collect_work.iwork_id'])
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    mention_id = Column(Integer, primary_key=True, nullable=False)
    iperson_id = Column(Integer, nullable=False)
    iwork_id = Column(Integer, primary_key=True, nullable=False)
    notes_on_person_mentioned = Column(Text)
    _id = Column(String(32))

    upload = relationship('CofkCollectPerson')
    upload1 = relationship('CofkCollectWork')
    upload2 = relationship('CofkCollectUpload')


class CofkCollectPlaceMentionedInWork(Base):
    __tablename__ = 'cofk_collect_place_mentioned_in_work'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iwork_id'], ['cofk_collect_work.upload_id', 'cofk_collect_work.iwork_id']),
        ForeignKeyConstraint(['upload_id', 'location_id'], ['cofk_collect_location.upload_id', 'cofk_collect_location.location_id'])
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    mention_id = Column(Integer, primary_key=True, nullable=False)
    location_id = Column(Integer, nullable=False)
    iwork_id = Column(Integer, primary_key=True, nullable=False)
    notes_on_place_mentioned = Column(Text)
    _id = Column(String(32))

    upload = relationship('CofkCollectWork')
    upload1 = relationship('CofkCollectLocation')
    upload2 = relationship('CofkCollectUpload')


class CofkCollectSubjectOfWork(Base):
    __tablename__ = 'cofk_collect_subject_of_work'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iwork_id'], ['cofk_collect_work.upload_id', 'cofk_collect_work.iwork_id']),
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    subject_of_work_id = Column(Integer, primary_key=True, nullable=False)
    iwork_id = Column(Integer, primary_key=True, nullable=False)
    subject_id = Column(ForeignKey('cofk_union_subject.subject_id', ondelete='CASCADE'), nullable=False)

    subject = relationship('CofkUnionSubject')
    upload = relationship('CofkCollectWork')
    upload1 = relationship('CofkCollectUpload')


class CofkCollectWorkResource(Base):
    __tablename__ = 'cofk_collect_work_resource'
    __table_args__ = (
        ForeignKeyConstraint(['upload_id', 'iwork_id'], ['cofk_collect_work.upload_id', 'cofk_collect_work.iwork_id']),
    )

    upload_id = Column(ForeignKey('cofk_collect_upload.upload_id'), primary_key=True, nullable=False)
    resource_id = Column(Integer, primary_key=True, nullable=False)
    iwork_id = Column(Integer, primary_key=True, nullable=False)
    resource_name = Column(Text, nullable=False, server_default=text("''::text"))
    resource_details = Column(Text, nullable=False, server_default=text("''::text"))
    resource_url = Column(Text, nullable=False, server_default=text("''::text"))
    _id = Column(String(32))

    upload = relationship('CofkCollectWork')
    upload1 = relationship('CofkCollectUpload')


t_cofk_collect_image_of_manif = Table(
    'cofk_collect_image_of_manif', metadata,
    Column('upload_id', ForeignKey('cofk_collect_upload.upload_id'), nullable=False),
    Column('manifestation_id', Integer, nullable=False),
    Column('image_filename', String(2000), nullable=False),
    Column('_id', String(32)),
    Column('iwork_id', Integer),
    ForeignKeyConstraint(['upload_id', 'iwork_id', 'manifestation_id'], ['cofk_collect_manifestation.upload_id', 'cofk_collect_manifestation.iwork_id', 'cofk_collect_manifestation.manifestation_id'])
)
