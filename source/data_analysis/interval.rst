========
Interval
========

Intervals are used when creating a :doc:`series` API call.  The interval specifies the length of each sub-timeframe in a Series.  For example, if you want the know how many users signed up each day for the last 7 days, your timeframe is **last 7 days** and your interval is **daily**.

Keen currently supports these intervals:

* **hourly** - breaks your timeframe into hourlong chunks.
* **daily** - breaks your timeframe into daylong chunks.
* **weekly** - breaks your timeframe into weeklong chunks.

To add an Interval to your Series, simply add the “interval” parameter to your query string.

An example Series call with a daily interval:

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/probes/count?api_key=<api_key>&event_name=<event_name>&timeframe=last_week&interval=daily