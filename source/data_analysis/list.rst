=========================
List of Unique Properties
=========================

This feature returns a list of property values from one property of an event collection. Only target_property values are returned (all duplicates are removed).

Some example uses of this feature:

* Get a list of email addresses for all the people that used a certain feature
* Get a list of all the different countries where you app is being used
* Get a list of all the different devices or browsers on which your app is being used
* Get a list of all the users who have purchased an upgrade for your app

Requesting the list is done via an HTTP GET request that uses the “select_unique” analysis type and follows this format:

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/<event_collection>/select_unique?api_key=<key>&target_property=<event_property>

Lists take the following parameters:

* **api_key** (required) - The API key for the project containing the data you are analyzing.  This goes in the Authorization HTTP header.
* **target_property** (required) - The name of the event property of interest. It should be a URL encoded JSON array containing one value.  If the property is a user defined property, it should be prepended with “body:” (e.g. body:email_address).  Otherwise, it should be prepended with "header:".
* **filters** (optional) - :doc:`filters` are used to narrow down the events used in an analysis request based on property values.
* **timeframe** (optional) - A :doc:`timeframe` specifies the events to use for analysis based on a window of time. If no timeframe is specified, all events will be counted.

Here’s a query populated with example values. We're looking at the Event Collection "logins" and the target_property we're analyzing is "body:user:email".

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/probes/select_unique?event_name=logins&target_property=%5B%22body%3Auser%3Aemail%22%5D&api_key=<api_key>

The response is a JSON object that looks like this:

.. code-block:: none

    {
        results: [value1, value2, value3, ...]
    }