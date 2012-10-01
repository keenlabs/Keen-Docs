=======================
Saved Queries & Queries
=======================

We believe our analysis APIs are simple to use, but we're not satisfied with just simple - they need to be as easy as possible. To that end, we created a way to save and reference your favorite Queries by name.  We call them "Saved Queries."

Saved Queries allow you to take a complex query like a :doc:`Metric <metrics>`, :doc:`Series <series>`, or :doc:`Progression <progressions>` and save it with a shortened, friendly name. We believe the simplified URL will make it easier for you to use your queries and build them into your applications. Saving your queries also allows you to easily update them on the fly using Keen's user interface. Plus, Saved Queries give us the opportunity to improve Keen response times for these known, saved queries.

"Saved Queries" are an alternative to "Queries", which are dynamically generated and used for exploratory purposes. I think an example is the best way to show the difference between Saved Queries and Queries. These two API requests yield the same result, but look different:


Example Query::

	https://api.keen.io/3.0/projects/<project_id>/queries/average?api_key=<key>&collection=purchases&filters=%5B%7B%22property_name%22%3A%22user%3Areferring_source%22%2C%22operator%22%3A%22eq%22%2C%22property_value%22%3A%22facebook%22%7D%5D&target_property=quantity&timeframe=yesterday

The Query is a complex URL with all of the parameters encoded in the URI. The advantages of Queries are:

1. You can modify Query parameters on the fly programmatically, or even in your browser bar. For example, you could take the Query above and replace "average" with "minimum" to change the nature of the calculation.
2. You can generate Queries programmatically. For example, suppose your app generates memes, each with a unique ID. Every time a user creates a new meme, you could generate a Query to count how many times that meme is shared.
3. You can see all of the parameters used in the query directly in the URI.


Example Saved Query::

	http://api.keen.io/3.0/projects/<projID>/saved_queries/Avg_fb_purchases_yesterday/result?api_key=<key>

A Saved Query is a Query that has been saved with a friendly name. The example Saved Query above is called "Avg_fb_purchases_yesterday". The advantages of Saved Queries:

1. Shorter, friendlier URL.
2. You can save your query and update it on the fly using the Keen user interface. That means if you use your Saved Query in code somewhere, and want to make an update to your :doc:`filter <filters>` logic, you don't need to deploy new code. Just log into Keen.io and modify the Saved Query. The URL won't change.
3. In fact... you can generate Saved Queries programmatically too. Check out the :ref:`API <saved-query-API>` section of this page if you want to do some advanced stuff with Saved Queries.


Create a Query or Saved Query via Keen UI
=========================================

You might have noticed that when you create a new :doc:`Metric <metrics>`, :doc:`Series <series>`, or :doc:`Progression <progressions>` using the Keen website that a Query URL is generated in real time as you specify your parameters. You can copy that URL into your browser at any time to get a result. If you choose to save your query, a Saved Query URL will also be generated and available for you to use. In fact both Queries & Saved Queries are always available for every analysis you save on Keen.io.



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
    "event_name": "bought_ticket", 
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
      "collection": "foo",
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
  
Once a Saved Insight has been created, you can update it by sending another PUT request to the same URL you used when creating it. Or you can delete it by sending a DELETE request to, again, that same URL.