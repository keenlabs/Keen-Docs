================
Data Extractions
================

Data Extractions are ways to get your data, or subsets of your data out of Keen and into other tools.  We strongly believe that you should always have full access to all of your data, and we aim to make it as simple and painless as possible.

The following types of Data Extractions are currently supported in the Keen Analysis API:

*  :ref:`extraction to file`
*  :ref:`list of unique properties`

Metrics are retrieved using HTTP GET requests to a URL for this format:

.. code-block:: none

    https://api.keen.io/<api_version>/projects/<project_id>/<event_collection>/_<extraction_type>

The variables in the URL are defined as follows:

* **api_version** - the version of the API you want to use.
* **project_id** - the ID of the project that contains the data you are analyzing.
* **event_collection** - the name of the event collection you are analyzing.
* **extraction_type** - the type of Metric you wish to use in this analysis.

Querystring parameters specific to the extraction type will be also be present -- such as :doc:`filters` or a specific :doc:`timeframe`.  See the documentation for the specific Data Extraction for more information.


.. _extraction to file:

Data Extraction to File
=======================

Requesting a Data Extraction to File will give you the events specified by any filters and/or timeframe in .csv format.  Your request is typically processed in under a minute. The Data Extraction APIs can be used to set up a nightly job that will have the data you need ready and waiting in your inbox in the morning.

Performing a Data Extraction to File is done via an HTTP POST request that looks like this:

.. code-block:: none

    https://api.keen.io/2.0/projects/<project_id>/<event_collection>/_extract

    Headers:
        Authorization: <api_key>
        Content-Type: application/json

    POST Body:

    {
    	"filters": [],
    	"timeframe": <timeframe>
    	"email": <email_address>
    }

Extractions take the following parameters:

* **api_key** (required) - The API key for the project containing the data you are analyzing.  This goes in the Authorization HTTP header.
* **filters** (required) - :doc:`filters` are used to narrow down the events used in an analysis request based on property values.  If you don't want to apply any filters, simply send an empty JSON array
* **timeframe** (optional) - A :doc:`timeframe` specifies the events to use for analysis based on a window of time. If no timeframe is specified, all events will be counted.
* **email_address** (optional) - If an email address is specified in the post body, an email will be sent that address when the extraction is complete.

An example POST body:

.. code-block:: none

    {
        "filters": [
            {
                "property_name": "body:amount",
                "operator": "gt",
                "property_value": 3.50
            }
        ],
        "timeframe": "last_4_days"
        "email": "alert@keen.io"
    }

The response looks like this:

.. code-block:: none

    {
        "_id": "<extraction_id>",
        "status": "not started",
    }

Getting the .CSV File
+++++++++++++++++++++

To check the status of the Extraction and retrieve the the URL of the resulting .CSV file, simply send an HTTP GET request to the following URL:

.. code-block:: none

    https://api.keen.io/2.0/projects/<project_id>/<event_collection>/_extract/<extraction_id>

    Headers:
        Authorization: <api_key>

* **api_key** (required) - The API key for the project containing the data you are analyzing.  This goes in the Authorization HTTP header.
* **extraction_id** (required) - The ID present in the _extract POST request.

The response will look like this:

.. code-block:: none

    {
        "status": "complete",
        "_id": ":EXTRACTION_ID:",
        "results_url": "https://s3.amazonaws.com/keen_service/..."
    }

.. note:: If the **status** is not complete, the **results_url** parameter will not be present.

The .CSV file containing your data is stored in the URL provided in the **results_url** parameter.

.. _list of unique properties:

List of Unique Properties
=========================

This feature returns a list of property values from one property of an event collection. Only unique property values are returned (all duplicates are removed).

Some example uses of this feature:

* Get a list of email addresses for all the people that used a certain feature
* Get a list of all the different countries where you app is being used
* Get a list of all the different devices or browsers on which your app is being used
* Get a list of all the users who have purchased an upgrade for your app

Requesting the list is done via an HTTP GET request that uses the “_select_unique” analysis type and follows this format:

.. code-block:: none

    https://api.keen.io/2.0/projects/<project_id>/<event_collection>/_select_unique?api_key=<key>&distinct_property=<event_property>

Lists take the following parameters:

* **api_key** (required) - The API key for the project containing the data you are analyzing.  This goes in the Authorization HTTP header.
* **distinct_property** (required) - The name of the event property of interest. It should be a URLencoded JSON array containing one value.  If the property is a user defined property, it should be prepended with “body:” (e.g. body:email_address).  Otherwise, it should be prepended with "header:".
* **filters** (optional) - :doc:`filters` are used to narrow down the events used in an analysis request based on property values.
* **timeframe** (optional) - A :doc:`timeframe` specifies the events to use for analysis based on a window of time. If no timeframe is specified, all events will be counted.

Here’s a query populated with example values. You can see the Event Collection were are analysis is Logins, the query type _select_unique, the distinct property body:user:email and the API key (no filters are used in this example, but you could add some).

.. code-block:: none

    https://api.keen.io/2.0/projects/5012efa95k546f2ce1000000/logins/_select_unique?&distinct_property=%5B%22body%3Auser%3Aemail%22%5D&api_key=bc77dd2ff8c34c2aa2972b0d6b2048c2

The response is a JSON object that looks like this:

.. code-block:: none

    {
        results: [value1, value2, value3, ...]
    }