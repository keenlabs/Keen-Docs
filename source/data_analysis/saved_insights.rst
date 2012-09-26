=======================
Saved Insights & Probes
=======================

We believe our analysis APIs are simple to use, but we're not satisfied with just simple - they need to be as easy as possible. To that end, we created a user interface for building queries and a new query type: Saved Insights.

Saved insights allow you to take a complex query like a :doc:`Metric <metrics>`, :doc:`Series <series>`, or :doc:`Progression <progressions>` and save it with a shortened, friendly name. We believe the simplified URL will make it easier for you to use your queries and build them into your applications. Saving your queries also allows you to easily update them on the fly using Keen.io's user interface. Plus, Saved Insights give us the opportunity to improve Keen response times for these known, saved queries.

"Saved Insights" are an alternative to "Probes", which is the name we give to dynamically generated or exploratory queries you use temporarily. I think an example is the best way to show the difference between Probes and Insights. These two queries yield the same result, but look different:


Example Probe::

	https://api.keen.io/3.0/projects/<projID>/probes/average?api_key=<key>&event_name=purchases&filters=%5B%7B%22property_name%22%3A%22body%3Auser%3Areferring_source%22%2C%22operator%22%3A%22eq%22%2C%22property_value%22%3A%22facebook%22%7D%5D&target_property=body:quantity&timeframe=yesterday

The Probe is a complex URL with all of the query parameters encoded in the URI. The advantages of Probes are:

1. You can modify probe query parameters on the fly programmatically, or even in your browser bar. For example, you could take the probe above and replace "average" with "minimum" to change the nature of the calculation.
2. You can generate probe queries programmatically. For example, suppose your app generates memes, each with a unique ID. Every time a user creates a new meme, you could generate a probe to count how many times that meme was shared.
3. You can see all of the parameters used in the query directly in the URI.


Example Saved Insight::

	http://api.keen.io/3.0/projects/<projID>/insights/Avg_fb_purchases_yesterday/result?api_key=<key>

A Saved Insight is a Probe that has been saved with a friendly name. The example Insight above is called "Avg_fb_purchases_yesterday". The advantages of Saved Insights:

1. Shorter, friendlier URL.
2. You can save your query and update it on the fly using the Keen.io user interface. That means if you use your Insight in code somewhere, and want to make an update to your :doc:`filter <filters>` logic, you don't need to deploy new code. Just log into Keen.io and modify the Insight. The URL won't change.
3. In fact... you can generate Saved Insights programmatically too. Check out the :ref:`API <insight-API>` section of this page if you want to do some advanced stuff with Saved Insights.


Create a Probe or Insight via Keen.io UI
========================================

You might have noticed that when you create a new :doc:`Metric <metrics>`, :doc:`Series <series>`, or :doc:`Progression <progressions>` using the Keen.io website that a Probe URL is generated in real time as you specify your parameters. You can copy that URL into your browser at any time to get a result. If you choose to save your query, a Saved Insight URL will also be generated and available for you to use. In fact both Probe & Saved Insights are always available for every analysis you save on Keen.io.



.. _insight-API:

Save an Insight via API
=======================

Technical Reference: :ref:`saved-insight-row-resource`

You can also programmatically create Saved Insights via API. Send an HTTP PUT to the following URL:

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
        "insight_results_url": "/3.0/projects/abc/insights/insight_one/results", 
        "insight_url": "/3.0/projects/abc/insights/insight_one"
      }
    }, 
    "updated": false
  }
  
Get the Results of an Insight
=============================

To get the results of an insight you've previously saved, send an HTTP GET to the following URL:

::

  https://api.keen.io/<api_version>/projects/<project_id>/insights/<insight_name>/results

The Results take the following parameter:

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. See :doc:`authentication` for more information.

If your request succeeds, you'll get a response that looks like:

::

  {
    "results": [
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