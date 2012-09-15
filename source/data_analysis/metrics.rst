=======
Metrics
=======
We use the world Metrics to describe analysis queries which return a single numeric value.  These simple yet powerful queries form the backbone of your analysis.  Metrics answer questions like “How many females in California used this feature yesterday?”

The following Metrics are currently supported in the Data Analysis API:

*  :ref:`count metric`
*  :ref:`count unique metric`

.. toctree::
   :maxdepth: 3
   
   
Metrics are retrieved using HTTP GET requests to a URL for this format:

.. code-block:: none

    https://api.keen.io/<api_version>/projects/<project_id>/probes/<metric_name>

The variables in the URL are defined as follows:

* **api_version** - the version of the API you want to use.
* **project_id** - the ID of the project that contains the data you are analyzing.
* **metric_name** - the type of Metric you wish to use in this analysis. Example: count_unique

Query string parameters specific to the analysis type will be also be present -- such as filters or a specific timeframe.  See the documentation for the specific Metric for more information.

.. _count metric:

Count
=====
Technical Reference: :ref:`count-resource`

Keen’s Count tool counts the number of events recorded that meet criteria you provide.

Some examples of questions you could answer with Counts:

* How many purchases have been made by users from Iowa in the last two weeks?
* How many times has a landing page been viewed?

Performing a Count is done via an HTTP GET request that follows this pattern:

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/probes/count?api_key=<api_key>&event_name=<event_name>

Counts take the following parameters:

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. See :doc:`authentication` for more information.
* **event_name** (required) - The name of the event collection you are analyzing.
* **filters** (optional) - :doc:`filters` are used to narrow down the events used in an analysis request based on `event property <event_properties>`_ values.
* **timeframe** (optional) - A :doc:`timeframe` specifies the events to use for analysis based on a window of time. If no timeframe is specified, all events will be counted.

.. note:: Adding :doc:`timeframe` and :doc:`interval` query string parameters will turn the Count request into a Series.  See the documentation on :doc:`Series<series>` for more information.

The response from a Count is a JSON object that looks like this:

.. code-block:: none

    {
        "result" : 7
    }



.. _count unique metric:

Count Unique
============
Technical Reference: :ref:`count-unique-resource`

Keen’s Count Unique tool counts the number of events that have a unique value for a given property.  A common use for this is to count the number of unique users that performed an event.

Some examples of questions you can answer with Count Unique:

* How many unique users have logged in to my application?
* How many unique people have viewed a landing page last week?
* How many different companies are using our app?
* In how many different countries is our app being used?

Performing a Count Unique is done via an HTTP GET request that follows this pattern:

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/probes/count_unique?api_key=<api_key>&event_name=<event_name>&unique_property=<property_name>

Count Unique takes the following query string parameters:

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. See :doc:`authentication` for more information.
* **event_name** (required) - The name of the event collection you are analyzing.
* **unique_property** (required) - The property of which you want to count the unique values.
* **filters** (optional) - :doc:`filters` are used to narrow down the events used in an analysis request based on `event property <event_properties>`_ values.
* **timeframe** (optional) - Similar to filters, a :doc:`timeframe` is used to narrow down the events used in an analysis request based on the time that the event occurred.

.. note:: Adding **timeframe** and **interval** query string parameters will turn the Count Unique request into a Series.  See the documentation on :doc:`Series<series>` for more information.

Here is an example of a request to return the number of unique users that logged in today:

.. code-block:: none

    https://api.keen.io/3.0/projects/your_project_id/probes/count_unique?event_name=logged_in&api_key=your_api_key&unique_property=body:user:email&timeframe=today

In this example, we are analyzing our “logged_in” event collection and telling it to count the unique property values in the **body:user:email** :ref:`hierarchical property <property hierarchy>`.  That property contains a way to identify a unique user -- the user’s email.

The response from a Count Unique request is a JSON object that looks like the following:

.. code-block:: none

    {
        "result" : 7
    }


