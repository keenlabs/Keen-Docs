=========
Timeframe
=========

A timeframe is the period of time over which you want to run an analysis.  Timeframes are used optionally in :doc:`metrics` and are required in :doc:`series` along with the Interval parameter.

Timeframes can be specified in two different ways:

* :ref:`relative-timeframes` - a timeframe that is relative to now.  Example: last week
* :ref:`absolute-timeframes` - a timeframe that is specified by two points in time.  Example: April 1st, 2012 at 4:00pm until April 15th, 2012 at 4:00pm.

.. _relative-timeframes:

Relative Timeframes
===================

.. note:: All times are UTC

Below are the supported relative timeframes:

* **last_n_hours** - Gives a start of n-hours before the most recent complete hour and an end at the most recent complete hour.  Example: If right now it is 7:15pm and I specify last_7_hours, the timeframe would stretch from noon until 7:00pm.
* **last_n_days** - Gives a starting point of n-days before the most recent complete day and an end at the most recent complete day.  Example: If right now is Friday at 9:00am and I specify a timeframe of "last_3_days", the timeframe would stretch from Tuesday morning at 12:00am until Thursday night at midnight.
* **last_n_weeks** - Gives a start of n-weeks before the most recent complete week and an end at the most recent complete week.  Example: If right now is Monday and I specify a timeframe of "last_2_weeks", the timeframe would stretch from three Sunday mornings ago at 12:00am until the most recent Sunday at 12:00am. (yesterday morning)
* **this_day** - Creates a timeframe starting from the beginning of the current day until now.
* **this_week** - Creates a timeframe starting from the beginning of the current week until now.
* **last_hour** - convenience for "last_1_hour"
* **last_day** - convenience for "last_1_day"
* **last_week** - convenience for "last_1_week"
* **yesterday** - convenience for "last_1_day"
* **today** - convenience for "this_day"

.. * **this_hour** - Creates a timeframe starting from the beginning of the current hour until now.

To specify a relative timeframe, simply add the **timeframe** parameter to your query string and set it equal to the relative time of your choice.

Example:

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/queries/count?api_key=<api_key>&collection=<event_collection>&timeframe=last_7_days

.. _absolute-timeframes:

Absolute Timeframes
===================

Absolute timeframes are specified similar to :doc:`filters`.

To specify an absolute timeframe, create a JSON object with "start" and "end" properties.  Set those properties equal to the desired start and end times in string form using :ref:`iso 8601 format`.

Example:

.. code-block:: none

    {
        "start" : "2012-08-13T19:00Z",
        "end" : "2013-09-20T19:00Z"
    }
    
Timeframes are either passed through a HTTP POST/PUT body, or through the query string of an HTTP GET. If you're making a GET request and you want to specify an absolute timeframe, you'll have to URL encode your JSON string using the proper method in your language of choice.

This is what the above example looks like URL encoded:

.. code-block:: none

    %7b%22start%22%3a%222012-08-13T19%3a00Z%22%2c%22end%22%3a%222013-09-20T19%3a00Z%22%7d

Finally, set the **timeframe** parameter in your query string equal to the URL encoded string.

Example:

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/queries/count?api_key=<api_key>&collection=<event_collection>&timeframe=%7b%22start%22%3a%222012-08-13T19%3a00Z%22%2c%22end%22%3a%222013-09-20T19%3a00Z%22%7d

.. _iso 8601 format:

ISO-8601 Format
=====================

ISO-8601 is an international standard for representing time data.  The format is as follows:

::

{YYYY}-{MM}-{DD}T{hh}:{mm}:{ss}.{SSS}{TZ}

* YYYY: Four digit year.  Example: "2012"
* MM: Two digit month.  Example: January would be "01"
* DD: Two digit day.  Example: The first of the month would be "01"
* hh: Two digit hour.  Example: The hours for 12:01am would be "00" and the hours for 11:15pm would be "23"
* mm: Two digit minute.
* ss: Two digit seconds.
* SSS: Milliseconds to the third decimal place.
* TZ: Time zone offset.  Specify a positive or negative integer. To specify UTC, add "Z" to the end.  Example: To specify Pacific time (UTC-8 hours), you should append "-0800" to the end of your date string. 

.. note:: If no time zone is specified, the date/time is assumed to be in local time. At Keen, we'll treat that as UTC.

Example ISO-8601 date strings:

.. code-block:: none

    2012-01-01T00:01:00-08:00
    1996-02-29T15:30:00+12:00
    2000-05-30T12:12:12Z
    
.. note:: Keen stores all date and time information in UTC.
