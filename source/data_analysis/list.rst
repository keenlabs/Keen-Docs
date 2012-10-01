=========================
List of Unique Properties
=========================

This feature returns a list of property values from one property of an event collection. Only target_property values are returned (all duplicates are removed).

Some example uses of this feature:

* Get a list of email addresses for all the people that used a certain feature
* Get a list of all the different countries where you app is being used
* Get a list of all the different devices or browsers on which your app is being used
* Get a list of all the users who have purchased an upgrade for your app

Requesting the list is done via an HTTP GET request that uses the "select_unique" analysis type and follows this format:

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/queries/select_unique?api_key=<key>&collection=<collection_name>&target_property=<property>

Lists take the following parameters:

* **api_key** (required) - The API key for the project containing the data you are analyzing.  This goes in the Authorization HTTP header.
* **target_property** (required) - The name of the event property of interest. For example "user.location.city". 
* **filters** (optional) - :doc:`filters` are used to narrow down the events used in an analysis request based on property values.
* **timeframe** (optional) - A :doc:`timeframe` specifies the events to use for analysis based on a window of time. If no timeframe is specified, all events will be counted.

.. Note:: Query string parameters much be URL-encoded or they will not be understood correctly. The query builder on Keen.io automatically does encoding. You can also do it using a simple tool like `URL Encoder <http://meyerweb.com/eric/tools/dencoder/URL>`. 

Here’s a query populated with example values. We're looking at the Event Collection "logins" and the target_property we're analyzing is "user.email".

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/queries/select_unique?collection=logins&api_key=<api_key>&target_property=user.email

The response is a JSON object that looks like this:

.. code-block:: none

    {
        results: [value1, value2, value3, ...]
    }