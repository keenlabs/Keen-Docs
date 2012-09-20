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
   authentication
   filters
   timeframe
   interval
   meta_analysis
   saved_insights

We are passionate about building powerful analysis APIs so you can get the most out of your data. Our services could be the building blocks for your new custom dashboard or a real-time workflow. I'm sure you'll think of even more uses we haven't considered yet :)

Here is the inventory of tools we've built so far. We'd love to get your feedback or ideas about what to build next. Let us know at team@keen.io.

* :doc:`metrics` - Answer questions about events that happened over a single period of time.  Example: The number of users that signed up last month.
* :doc:`series` - Analyze data over a period of time broken into smaller periods of time.  Example: The number of users that signed up each day last week.
* :doc:`progressions` - Analyze the dropoff rates of users as they progress through a set of steps.  Example: What is the conversion rate of users landing on the site to creating an account to upgrading their account?
* :doc:`extractions` - Extract all or subsets of your data in its raw form.
* :doc:`list` - Get a list of target_property values (for example user names).
* :doc:`meta_analysis` - Get information about your projects, collections, extractions, etc.
* :doc:`saved_insights` - Save your metric, series, or progression so you can reuse them later.

The analysis APIs have some common parameters that apply to all of them.

* :doc:`authentication` - Used to tell us who you are, so that unauthorized people can't see your data.
* :doc:`filters` - Used to narrow down your data to the sub-selection based on event properties.
* :doc:`timeframe` - Used to narrow down your data to a sub-selection based on timestamp.
* :doc:`interval` - Used to specify the time intervals in a :doc:`series`.
