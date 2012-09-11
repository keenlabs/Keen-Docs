==================
Data Analysis APIs
==================

.. toctree::
   :hidden:
   
   metrics    
   series
   progressions
   extractions
   list
   filters
   timeframe
   interval
   meta_analysis

We are building a set of analysis APIs so you can use your data in whatever way you want. You can build a custom dashboards or real-time workflows. Here is the inventory of tools we've built so far. 

* :doc:`metrics` - Answer questions about events that happened over a single period of time.  Example: The number of users that signed up last month.
* :doc:`series` - Analyze data over a period of time broken into smaller periods of time.  Example: The number of users that signed up each day last week.
* :doc:`progressions` - Analyze the dropoff rates of users as they progress through a set of steps.  Example: What is the conversion rate of users landing on the site to creating an account to upgrading their account?
* :doc:`extractions` - Extract all or subsets of your data in its raw form.
* :doc:`list` - Get a list of unique property values (for example user names)
* :doc:`meta_analysis` - Get information about your projects, collections, extractions, etc

The analysis APIs have some common parameters that apply to all of them.

* :doc:`filters` - used to narrow down your data to the sub-selection based on event properties
* :doc:`timeframe` - used to narrow down your data to a sub-selection based on timestamp
* :doc:`interval` - used to specify the time intervals in a :doc:`series`
