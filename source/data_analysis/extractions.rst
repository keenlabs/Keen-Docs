================
Data Extractions
================

Data Extractions are ways to get your data, or subsets of your data out of Keen and into other tools.  We strongly believe that you should always have full access to all of your data, and we aim to make it as simple and painless as possible.

The following types of Data Extractions are currently supported in the Keen Analysis API:

*  :ref:`extraction to file` - a .CSV file will all of your event properties
*  :doc:`list` - a list of unique properties (for example user names)

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


Check out the details in the API reference guide:
	:ref:`extractions-resource` - Returns available extractions and their statuses. Post to this resource to create a new extraction.
	:ref:`extraction-row-resource` - GET returns detailed information about a particular extraction (including a link to its results if the extraction has completed).

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

