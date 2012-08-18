=======
Metrics
=======
We use the world Metrics to describe analysis queries which return a single numeric value.  These simple yet powerful queries form the backbone of your analysis.  Metrics answer questions like “How many females in California used this feature yesterday?”

The following Metrics are currently supported in the Keen Analysis API:

*  :ref:`count`
*  :ref:`count_unique`

Metrics are retrieved using HTTP GET requests to a URL for this format:

.. code-block:: none

    https://api.keen.io/<api_version>/projects/<project_id>/<event_collection>/_<metric_name>

The variables in the URL are defined as follows:

* **api_version** - the version of the API you want to use.
* **project_id** - the ID of the project that contains the data you are analyzing.
* **event_collection** - the name of the event collection you are analyzing.
* **metric_name** - the type of Metric you wish to use in this analysis.

Querystring parameters specific to the analysis type will be also be present -- such as filters or a specific timeframe.  See the documentation for the specific Metric for more information.

.. _count:

Count
=====
Keen’s Count tool counts the number of events recorded that meet criteria you provide.

Some examples of questions you could answer with Counts:

* How many purchases have been made by users from Iowa in the last two weeks?
* How many times has a landing page been viewed?

Performing a Count is done via an HTTP GET request that follows this pattern:

.. code-block:: none

    https://api.keen.io/2.0/projects/<project_id>/<event_collection>/_count?api_key=<api_key>

Counts take the following parameters:

* **api_key** (required) - The API key for the project containing the data you are analyzing.
* **timeframe** (optional) - A timeframe specifies the events to use for analysis based on a window of time. If no timeframe is specified, all events will be counted.
* **filters** (optional) - Filters are used to narrow down the events used in an analysis request based on property values.

.. note:: Adding **timeframe** and **interval** querystring parameters will turn the Count request into a Series.  See the documentation on :doc:`Series<series>` for more information.

The response from a Count is a JSON object that looks like this:

.. code-block:: none

    {
        result : 7
    }

.. _count_unique:

Count Unique
============
Keen’s count unique tool counts the number of events that have a unique value for a given property.  A common use for this is to count the number of unique users that performed an event.

Some examples of questions you can answer with count unique:

* How many unique users have logged in to my application?
* How many unique people have viewed a landing page last week?
* How many different companies are using our app?
* In how many different countries is our app being used?

Performing a count unique is done via an HTTP GET request that follows this pattern:

.. code-block:: none

    https://api.keen.io/2.0/projects/<project_id>/<event_name>/_count_unique?api_key=<api_key>&unique_property=<property_name>

Count Unique takes the following querystring parameters:

* **api_key** (required) - The API key for the project containing the data you are analyzing.
* **unique_property** (required) - The property of which you want to count the unique values.
* **timeframe** (optional) - Similar to filters, timeframes are used to narrow down the events used in an analysis request based on the time that the event occurred.
* **filters** (optional) - Filters are used to narrow down the events used in an analysis request based on property values.

.. note:: Adding **timeframe** and **interval** querystring parameters will turn the Count Unique request into a Series.  See the documentation on :doc:`Series<series>` for more information.

Here is an example of a request to return the number of unique users that logged in today:

.. code-block:: none

    https://api.keen.io/2.0/projects/your_project_id/logged_in/_count_unique?api_key=your_api_key&unique_property=body:user:email&timeframe=today

In this example, we are analyzing our “logged_in” event collection and telling it to count the unique values in the **body:user:email** hierarchical property.  That property contains a way to identify a unique user -- the user’s email.

The response from a count_unique request is a JSON object that looks like the following:

.. code-block:: none

    {
            result : 7
    }