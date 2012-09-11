=========================
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