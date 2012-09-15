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
Technical Reference: :ref:`extraction-resource`

Requesting a Data Extraction to File will give you the events specified by any filters and/or timeframe in .csv format. The Data Extraction APIs can be used to set up a nightly job that will have the data you need ready and waiting in your inbox in the morning.

Performing a Data Extraction to File is done via an HTTP GET request that follows this pattern:

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/probes/extraction?api_key=<api_key>&event_name=<event_name>

Extractions take the following parameters:

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. See :doc:`authentication` for more information.
* **event_name** (required) - The name of the event collection you are analyzing.
* **filters** (optional) - :doc:`filters` are used to narrow down the events used in an analysis request based on `event property <event_properties>`_ values.
* **timeframe** (optional) - A :doc:`timeframe` specifies the events to use for analysis based on a window of time. If no timeframe is specified, all events will be counted.
* **email_address** (optional) - If an email address is specified, an email will be sent that address when the extraction is complete.

.. note:: There are two forms of responses. If **email_address** is specified, then the request will be processed asynchronously and an email will be delivered when it completes. If **email_address** is omitted, the request is processed synchronously and the response will be a CSV file containing the results of the extraction.