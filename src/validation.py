import datetime

import pandas


def get_value(work, value):
    if value in work:
        return work[value]


def validate_date(y, m, d):
    # Make sure year is early modern inclusive.
    if not 1900 >= y >= 1500:
        raise ValueError('date_of_work_std_year is {} but must be between {} and {}'.format(y, 1500, 1900))

    # Make sure month is between 1-12
    if not 0 < m < 13:
        raise ValueError('date_of_work_std_month is {} but must be between 1 and 12'.format(m))

    # Check day of month
    if d is not None:
        # If month is April, June, September or November then day must be not more than 30
        if m in [4, 6, 9, 11] and d > 30:
            raise ValueError('date_of_work_std_day is {} but must be between 1 and 30 for April,'
                             'June, September or November'.format(d))

        # For February not more than 29
        elif m == 2 and d > 29:
            raise ValueError('date_of_work_std_day is {} but must be between 1 and 29 for February'.format(d))

        # Otherwise
        elif d > 31:
            raise ValueError('date_of_work_std_day is {} but must be between 1 and 31'.format(d))


def validate_dates(work):
    """
    Validating using manual string comparison because it is unclear at this time how
    use of different calendars (Gregorian, Julian, other or unknown) will affect date
    validation.
    :param work:
    :return:
    """
    date_of_work_std_year = get_value(work, 'date_of_work_std_year')
    date_of_work_std_month = get_value(work, 'date_of_work_std_month')
    date_of_work_std_day = get_value(work, 'date_of_work_std_day')
    date_of_work_std_is_range = get_value(work, 'date_of_work_std_is_range')

    validate_date(date_of_work_std_year, date_of_work_std_month, date_of_work_std_day)

    # Date is a range, switch between Julian to Gregorian calendar was around October 1582.
    # This could get sticky.
    if date_of_work_std_is_range == 1:
        date_of_work2_std_year = get_value(work, 'date_of_work2_std_year')
        date_of_work2_std_month = get_value(work, 'date_of_work2_std_month')
        date_of_work2_std_day = get_value(work, 'date_of_work2_std_day')

        validate_date(date_of_work2_std_year, date_of_work2_std_month, date_of_work2_std_day)

        first_date = datetime.datetime(date_of_work_std_year, date_of_work_std_month, date_of_work_std_day)
        second_date = datetime.datetime(date_of_work2_std_year, date_of_work2_std_month, date_of_work2_std_day)

        if first_date >= second_date:
            raise ValueError("The start date in a date range can not be after the end date.")

    notes_on_date_of_work = get_value(work, 'notes_on_date_of_work')

    if notes_on_date_of_work[0].islower():
        raise ValueError("Notes with dates have to start with an upper case letter.")

    if notes_on_date_of_work[-1] != '.':
        raise ValueError("Notes with dates have to end with a full stop.")


def validate_places(work):
    destination_name = get_value(work, 'destination_name')
    destination_id = get_value(work, 'destination_id')
    origin_name = get_value(work, 'origin_name')
    origin_id = get_value(work, 'origin_id')

    if not (destination_id or destination_name):
        raise ValueError("There is neither a destination_id nor a destination_name.")

    if not (origin_id or origin_name):
        raise ValueError("There is neither a origin_id nor a origin_name.")

    # If place id is provided it overrides the name provided regardless if it's
    # unknown or something else.

    if destination_name and not destination_id and "unknown" == destination_name.strip().lower():
        raise ValueError("Destination name must not be \"unknown\".")

    if origin_name and not origin_id and "unknown" == origin_name.strip().lower():
        raise ValueError("Origin name must not be \"unknown\".")


def validate_languages(work):
    lang = get_value(work, 'language_id')

    codes = pandas.read_csv('languages.csv').language_code.to_list()

    if not all(l in codes for l in lang.split(';')):
        raise ValueError("Not all values in language_id are valid 3-digit ISO language codes.")

    # Explicitly deleting language codes as it is a list of 8224 3 digit codes
    del codes


def validate_keywords(work):
    keywords = get_value(work, 'keywords')

    if len(keywords.split('; ')) - 1 != keywords.count(';'):
        raise ValueError("Not all keywords are properly separated with a space after the separator, ;.")


def validate_work(df):
    for i in range(1, len(df.index)):
        work = {k: v for k, v in df.iloc[i].to_dict().items() if v is not None}

        validate_dates(work)

        validate_places(work)

        validate_languages(work)

        validate_keywords(work)


def validate_manifestation(df):
    for i in range(1, len(df.index)):
        manifestation = {k: v for k, v in df.iloc[i].to_dict().items() if v is not None}

        if not all(m in manifestation for m in ['manifestation_type', 'repository_id', 'id_number_or_shelfmark']):
            raise ValueError('manifestation_type, repository_id or id_number_or_shelfmark missing from manifestation.')

        if manifestation['id_number_or_shelfmark'].find('-') > -1:
            raise ValueError('There should be an en dash used between folio numbers, not a hyphen.')

        if manifestation['id_number_or_shelfmark'][-1] != '.':
            raise ValueError('There should not be a full stop at the end of a shelfmark.')

        if 'printed_edition_details' in manifestation:
            if manifestation['printed_edition_details'][-1] != '.':
                raise ValueError('There should not be a full stop at the end of'
                                 ' bibliographic details of a manifestation.')

            if manifestation['printed_edition_details'].find('-') > -1 and \
                    manifestation['printed_edition_details'].find('–') == -1:
                raise ValueError("It seems you are using hyphens to indicate a page range when you"
                                 "should be using en dashes.")