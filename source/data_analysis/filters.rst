=======
Filters
=======

A filter is a criterion applied to a collection of events to narrow down the events used for analysis.  For example, you could apply a filter so you are only analyzing events that came from Android users.

Filters are passed into URLs as an array of JSON objects.  Each JSON object has three properties:

* **property_name** (required) - the name of the property on which you’d like to filter.
* **operator** (required) - the string code for the filter operator you’d like to use.
* **value** (required) - the value to compare to the property specified in "property_name".

.. include:: operators.txt

Because not all filter operators make sense for the different property data types, only certain ones are valid for each type.

* string - eq, ne, lt, gt, exists, in
* number - eq, ne, lt, lte, gt, gte, exists, in
* boolean - eq, exists, in

Example: Here is the JSON array for two filters.  The first one restricts our events to only those with a *price* property greater than or equal to .99.  The second one restricts our events to only those whose *on_sale* property is set to *true*.

.. code-block:: none

	[
	    {
	        "property_name" : "price",
	        "operator" : "gte",
	        "property_value" : .99
	    },
	    {
	        "property_name" : "on_sale"
	        "operator" : "eq"
	        "property_value" : true
	    }
	]
    
Filters are either passed through a HTTP POST/PUT body, or through the query string of an HTTP GET. If you're making a GET request and you want to specify some filters, you'll have to URL encode your JSON string using the proper method in your language of choice.

Finally, set the "filters" parameter in your query string equal to the URL encoded string.

Example:

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/queries/count?api_key=<api_key>&event_name=<event_name>&filters=%5b%7b%22property_name%22%3a%22price%22%2c%22operator%22%3a%22gte%22%2c%22property_value%22%3a.99%7d%2c%7b%22property_name%22%3a%22on_sale%22%2c%22operator%22%3a%22eq%22%2c%22property_value%22%3atrue%7d%5d

PS: The query builder on keen.io will construct and decode filters into a URL for you.
