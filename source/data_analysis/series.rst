======
Series
======

A Series allows you to analyze trends in :doc:`Metrics<metrics>` over time. It breaks a timeframe into intervals of hours, days, or weeks, and returns Metrics (numbers) for each of those intervals.

Creating a series request is done by simply adding the :doc:`timeframe` and :doc:`interval` query string parameters to a :doc:`Metric<metrics>` request.

.. note:: The **timeframe** parameter is already optional for Metrics.  If you are already using a timeframe with a Metric, you only need to add the **interval** query string parameter to turn your Metric into a Series.

Here’s an example that counts the number of purchases events we have recorded for each day last week.

.. code-block:: none

    http://api.keen.io/3.0/projects/<project_id>/probes/count?api_key=<key>&event_name=purchases&interval=daily&timeframe=last_3_days

The output of a Series request is an array of JSON dictionaries which include the value for each interval in the timeframe.  Here is what the output looks like in our example:

.. code-block:: none

    {
        "result":[
            {
                "value": 12,
                "timeframe": {
                    "start": "2012-08-05T00:00:00",
                    "end": "2012-08-06T00:00:00"
                }
            },
            {
                "value": 6585,
                "timeframe":{
                    "start": "2012-08-06T00:00:00",
                    "end": "2012-08-07T00:00:00"
                }
            },
            {
                "value": 3586,
                "timeframe": {
                    "start": "2012-08-07T00:00:00",
                    "end": "2012-08-08T00:00:00"
                }
            },
        ]
    }

As you might have noticed, the series output forms the data set for a basic bar chart or line graph.

Here are some example questions you could answer with a Series:

* How many times was content shared in the last 24 hours? When was the most popular time to share?
* How much revenue was generated for each of the past 8 weeks?
* Is the usage of our new feature increasing?
* How many users signed up each day last week?