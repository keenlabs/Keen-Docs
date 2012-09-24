====================
Data Collection APIs
====================

We built a massively scalable event data warehouse so that you can send us whatever data you want without having to worry about storage or performance.

Our public REST API lets you send data using standard HTTP POST methods, from any device. Try it out really quickly using cURL in our :doc:`/getting_started_guide`.

These two links have all the technical details you need for sending data to our REST API:

* :ref:`event-collections-list-resource` - Used for bulk-inserting events into Keen.
* :ref:`event-collection-row-resource` - Used for inserting single events into Keen.

Our SDKs make integration even simpler. Check out our client usage guides for the steps to integrate your app for data collection: 

.. toctree::
   :maxdepth: 1

   /clients/iOS/usage_guide 
   /clients/ruby/usage_guide
   
Or take a look at our :doc:`/api/reference` for all the nitty-gritty details of our REST API.

Unlike traditional databases like SQL, our database has no schema. You no longer need to think of data as a row with a limited number of columns. Our database holds JSON documents - they’re hierarchical and can have as many fields and values as you want. 

If you're new to unstructured data, take a look at the :doc:`../event_data_modeling/event_data_intro` to get some ideas about how to model they data you send to Keen.