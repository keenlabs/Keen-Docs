==============
Saved Insights
==============

An insight is what you get (hopefully!) after you get the results of :doc:`metrics`, :doc:`series`, :doc:`progressions`, or :doc:`extractions`. We believe our APIs for these analysis calls are simple to use, but we're not satisfied with just simple - they need to be as easy as possible. To that end, we created Saved Insights, which allows you to take the definition for one of those analysis calls and save it to Keen itself, so you can re-use it whenever you want.

Technical Reference: :ref:`saved-insight-row-resource`

Save an Insight
===============

To save an insight to Keen, send an HTTP PUT to the following URL:

::

  https://api.keen.io/<api_version>/projects/<project_id>/insights/<insight_name>
  
The variables in the URL are defined as follows:

* **api_version** - the version of the API you want to use.
* **project_id** - the ID of the project that contains the data you are analyzing.
* **insight_name** - the name you want to give to the saved insight

The body of the HTTP PUT request needs to contain all the properties of your saved insight. The parameters will vary depending on what analysis type you're trying to save. 

.. include:: saved_insight_parameters.txt

For example, if you want to save a Series Count named "my_first_count" on the Event Collection "bought_ticket" with the interval "hourly" and the timeframe "today", your HTTP Put body would look like:

::

  {
    "analysis_type": "count", 
    "event_name": "bought_ticket", 
    "interval": "hourly", 
    "timeframe": "today"
  }
  
Make sure to authenticate your request. See :doc:`authentication` for more information.
  
If your attempt to save the insight succeeds, you'll get a response like:

::

  {
    "created": true, 
    "insight": {
      "analysis_type": "count", 
      "created_date": "2012-09-14T22:23:50.259178", 
      "event_name": "foo", 
      "filters": [], 
      "insight_name": "my_first_count", 
      "insight_type": "metric", 
      "interval": "hourly", 
      "last_modified_date": "2012-09-14T22:23:50.259178", 
      "timeframe": "today", 
      "urls": {
        "insight_results_url": "/3.0/projects/abc/insights/insight_one/result", 
        "insight_url": "/3.0/projects/abc/insights/insight_one"
      }
    }, 
    "updated": false
  }
  
Get the Results of an Insight
=============================

To get the results of an insight you've previously saved, send an HTTP GET to the following URL:

::

  https://api.keen.io/<api_version>/projects/<project_id>/insights/<insight_name>/result

The Results take the following parameter:

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. See :doc:`authentication` for more information.

If your request succeeds, you'll get a response that looks like:

::

  {
    "result": [
      {
        "timeframe": {
          "end": "2012-09-15T01:00:00", 
          "start": "2012-09-15T00:00:00"
        }, 
        "value": 1
      }, 
      {
        "timeframe": {
          "end": "2012-09-15T02:00:00", 
          "start": "2012-09-15T01:00:00"
        }, 
        "value": 0
      },
      ...
    ]
  }
  
Once an insight's been created, you can update it by sending another PUT request to the same URL you used when creating it. Or you can delete it by sending a DELETE request to, again, that same URL.