================
Data Extractions
================

Data Extractions allow you to get your event data out of Keen IO.  We strongly believe that you should always have full access to all of your data, and we aim to make it as simple and painless as possible.

The following types of Data Extractions are currently supported in the Keen Analysis API:

*  :ref:`extraction-to-file` - request a .CSV file with all of your events (or a subset of them)
*  :ref:`extraction-to-JSON` - extract all events in a collection in JSON format
*  :ref:`latest-events` - extract the most recent N events of a given event collection 
*  :doc:`list` - extract a list of unique properties values (for example user names)



.. _extraction-to-JSON:

Data Extraction to JSON
=======================

Technical Reference: :ref:`extraction-resource`

A JSON data extraction is done using an HTTP GET request like this: 

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/queries/extraction?api_key=<api_key>&event_collection=<event_collection>


.. include:: extraction-parameters.txt

The result is an array of events like this:

.. code-block:: none

    {"result":[{
                "keen": {
                    "created_at": "2012-07-30T21:21:46.566000+00:00", 
                    "timestamp": "2012-07-30T21:21:46.566000+00:00"
                        }, 
                "user": {
                    "email": "dan@keen.io", 
                    "id": "4f4db6c7777d66ffff000000"
                        }, 
                "user_agent": {
                    "browser": "chrome", 
                    "browser_version": "20.0.1132.57", 
                    "platform": "macos"
                              },
                }, 
                {
                "keen": {
                    "created_at": "2012-07-30T21:40:05.386000+00:00", 
                    "timestamp": "2012-07-30T21:40:05.386000+00:00"
                        },
                "user": {
                    "email": "michelle@keen.io", 
                    "id": "4fa2cccccf546ffff000006"
                        }, 
                "user_agent": {
                    "browser": "chrome", 
                    "browser_version": "20.0.1132.57", 
                    "platform": "macos"
                              }
                }
            ]
    }



.. _extraction-to-file:

Data Extraction to CSV file
===========================

Technical Reference: :ref:`extraction-resource`

You can perform a file extraction at any time from the Keen.io website or via API. Shortly after requesting an extract from the Keen.io website, you will get an email letting you know that the extract is ready for download. The larger your extraction, the longer it will take to get the email. When you click the link, your CSV download will begin immediately (check the bottom of your browser -- you should see the download progress there).

Here's what the API request looks like:

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/queries/extraction?api_key=<api_key>&event_collection=<event_collection>&email_address=<email>
    

.. include:: extraction-parameters.txt



.. _latest-events:

Latest Events Extractions
=========================

Add a 'latest' parameter to your extraction request to get back the last 5 events, last 10 events, etc. Request up to 100 of the most recent events.

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/queries/extraction?api_key=<api_key>&event_collection=<event_collection>&latest=<number>

.. include:: extraction-parameters.txt

The result is an array of your custom events and properties. Here's an example using two sample login events:

.. code-block:: none

    {"result":[{
                "keen": {
                    "created_at": "2012-07-30T21:21:46.566000+00:00", 
                    "timestamp": "2012-07-30T21:21:46.566000+00:00"
                        }, 
                "user": {
                    "email": "dan@keen.io", 
                    "id": "4f4db6c7777d66ffff000000"
                        }, 
                "user_agent": {
                    "browser": "chrome", 
                    "browser_version": "20.0.1132.57", 
                    "platform": "macos"
                              },
                }, 
                {
                "keen": {
                    "created_at": "2012-07-30T21:40:05.386000+00:00", 
                    "timestamp": "2012-07-30T21:40:05.386000+00:00"
                        },
                "user": {
                    "email": "michelle@keen.io", 
                    "id": "4fa2cccccf546ffff000006"
                        }, 
                "user_agent": {
                    "browser": "chrome", 
                    "browser_version": "20.0.1132.57", 
                    "platform": "macos"
                              }
                }
            ]
    }

.. _extraction-notes:

Notes on Data Extraction
=========================

Technical Reference: :ref:`extraction-resource`

Here is some additional info related to data extraction:

* If you don't specify any filters, your extract will include every event in an :ref:`Event Collection<event-collections>`. All :ref:`event-properties` are included for each event in the extract. The files can get quite large. Use timeframes and filters to narrow the inventory of events that you extract.

* Every event in your extract will have a :ref:`keen.timestamp <property-types>` property. That's the value used for sorting events by :doc:`timeframe`. The timezone of this timestamp is GMT.

* There is currently no way to specify the order of the properties (columns) in your extract file. They might not come out in the order you expect, but they will all be there.

* Shortly after requesting an extract from the Keen.io website, you will get an email letting you know that the extract is ready for download. The larger your extraction, the longer it will take to get the email. When you click the link, your download will begin immediately (check the bottom of your browser -- you should see the download progress there).

* Extractions are done by :ref:`Event Collection<event-collections>`. If you want to extract 100% of your data from Keen, you'll need to run the extraction for each Event Collection.

* You can also programmatically request extractions via the :ref:`extraction-resource` or using :doc:`saved-queries` in our API. The Data Extraction APIs can be used to, for example, set up a nightly job that will have the data you need ready and waiting in your inbox in the morning.