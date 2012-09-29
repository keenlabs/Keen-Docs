================
Data Extractions
================

Data Extractions are ways to get your data, or subsets of your data out of Keen and into other tools.  We strongly believe that you should always have full access to all of your data, and we aim to make it as simple and painless as possible.

The following types of Data Extractions are currently supported in the Keen Analysis API:

*  :ref:`extraction to file` - a .CSV file with all of your events (or a subset of them)
*  :doc:`list` - a list of unique properties (for example user names)

.. _extraction to file:

Data Extraction to File
=======================
Technical Reference: :ref:`extraction-resource`

You can perform a data extraction at any time from the Keen.io website or via API. We wanted to let you know some things about the extraction file:

* If you don't specify any filters, your extract will include every event in an :ref:`Event Collection<event-collections>`. All :ref:`event-properties` are included for each event in the extract. The files can get quite large. Use timeframes and filters to narrow the inventory of events that you extract.

* Every event in your extract will have a :ref:`keen:timestamp <property-types>` property. That's the value used for sorting events by :doc:`timeframe`. The timezone of this timestamp is GMT.

* There is currently no way to specify the order of the properties (columns) in your extract file. They might not come out in the order you expect, but they will all be there.

* Shortly after requesting an extract from the Keen.io website, you will get an email letting you know that the extract is ready for download. The larger your extraction, the longer it will take to get the email. When you click the link, your download will begin immediately (check the bottom of your browser -- you should see the download progress there).

* Extractions are done by :ref:`Event Collection<event-collections>`. If you want to extract 100% of your data from Keen, you'll need to run the extraction for each Event Collection.

You can also programmatically request extractions via the :ref:`extraction-resource` or via :doc:`saved_insights` in our API. The Data Extraction APIs can be used to, for example, set up a nightly job that will have the data you need ready and waiting in your inbox in the morning.

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