=======================
Saved Queries & Queries
=======================

We believe our analysis APIs are simple to use, but we're not satisfied with just simple - they need to be as easy as possible. To that end, we created a way to save and reference your favorite Queries by name.  We call them "Saved Queries."

Saved Queries allow you to take a complex query like a :doc:`Metric <metrics>`, :doc:`Series <series>`, or :doc:`Progression <progressions>` and save it with a shortened, friendly name. This simplified URL will make it easier for you to build queries into your applications. Saving Queries also allows you to easily update them on the fly using Keen's user interface. Plus, Saved Queries give us the opportunity to improve Keen response times.

Whenever you generate a query using the Keen.io UI, you'll see the query URL being generated on the fly as you add parameters. Once you save the query, a shorted "Saved Query" URL will be generated. 

Example Query::

	https://api.keen.io/3.0/projects/<project_id>/queries/average?api_key=<key>&event_collection=purchases&filters=%5B%7B%22property_name%22%3A%22user%3Areferring_source%22%2C%22operator%22%3A%22eq%22%2C%22property_value%22%3A%22facebook%22%7D%5D&target_property=quantity&timeframe=yesterday

Example Saved Query::

	http://api.keen.io/3.0/projects/<projID>/saved_queries/Avg_fb_purchases_yesterday/result?api_key=<key>

.. _saved-query-API:

Save a Query via API
=======================

Technical Reference: :ref:`saved-query-row-resource`

You can also programmatically create Saved Queries via API. Send an HTTP PUT to the following URL:

::

  https://api.keen.io/<api_version>/projects/<project_id>/saved_queries/<saved_query_name>
  
The variables in the URL are defined as follows:

* **api_version** - the version of the API you want to use.
* **project_id** - the ID of the project that contains the data you are analyzing.
* **saved_query_name** - the name you want to give to the Saved Query

The body of the HTTP PUT request needs to contain all the properties of your Saved Query. The parameters will vary depending on what analysis type you're trying to save.

.. include:: saved_query_parameters.txt

For example, if you want to save a Series Count named "my_first_count" on the Event Collection "bought_ticket" with the interval "hourly" and the timeframe "today", your HTTP Put body would look like:

::

  {
    "analysis_type": "count", 
    "event_collection": "bought_ticket", 
    "interval": "hourly", 
    "timeframe": "today"
  }
  
Make sure to authenticate your request. See :doc:`authentication` for more information.
  
If your attempt to save the Query succeeds, you'll get a response like:

::

  {
    "created": true, 
    "saved_query": {
      "analysis_type": "count", 
      "created_date": "2012-09-14T22:23:50.259178",
      "event_collection": "foo",
      "filters": [], 
      "saved_query_name": "my_first_count",
      "saved_query_type": "metric",
      "interval": "hourly", 
      "last_modified_date": "2012-09-14T22:23:50.259178", 
      "timeframe": "today", 
      "urls": {
        "saved_query_results_url": "/3.0/projects/abc/saved_queries/my_first_count/result",
        "saved_query_url": "/3.0/projects/abc/saved_queries/my_first_count"
      }
    }, 
    "updated": false
  }
  
Get the Results of a Saved Query
================================

To get the results of a Saved Query you've previously saved, send an HTTP GET to the following URL:

::

  https://api.keen.io/<api_version>/projects/<project_id>/saved_queries/<saved_query_name>/result

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
  

Once a Saved Query has been created, you can update it by sending another PUT request to the same URL you used when creating it. Or you can delete it by sending a DELETE request to, again, that same URL.