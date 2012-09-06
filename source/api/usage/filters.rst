=======
Filters
=======

A filter is a criterion applied to a collection of events to narrow down the events used for analysis.  For example, you could apply a filter so you are only analyzing events that came from Android users.

Filters are passed into URLs as an array of JSON objects.  Each JSON object has three properties:

* **property_name** (required) - the name of the property on which you’d like to filter.
* **operator** (required) - the string code for the filter operator you’d like to use.
* **value** (required) - the value to compare to the property specified in “property_name”.

.. note:: **property_name** will need the “body” prefix to filter on user defined properties.

Filter operators are :

* **eq** - Equal to
* **ne** - Not equal to
* **lt** - Less than
* **lte** - Less than or equal to
* **gt** - Greater than
* **gte** - Greater than or equal to
* **exists** - Whether or not a specific property exists on an event record.  When using the “exists” operator, the value passed in must be either “true” or “false”
* **in** - Whether or not the property value is in a given set of values.  When using the “in” operator, the value must be a JSON array of values.  Example: [1,2,4,5]

Because not all filter operators make sense for the different property data types, only certain ones are valid for each type.

* string - eq, ne, lt, gt, exists, in
* number - eq, ne, lt, lte, gt, gte, exists, in
* boolean - eq, exists, in

Example: Here is the JSON array for two filters.  The first one restricts our events to only those with a *price* property greater than or equal to .99.  The second one restricts our events to only those whose *on_sale* property is set to *true*.

.. code-block:: none

    [
        {
            “property_name” : “body:price”,
            “operator” : “gte”,
            “property_value” : .99
        },
        {
            “property_name” : “body:on_sale”
            “operator” : “eq”
            “property_value” : true
        }
    ]

Next, URLencode your JSON string using the proper method in your language of choice.

This is what the above example looks like URLencoded:

.. code-block:: none

    %5b%7b%22property_name%22%3a%22body%3aprice%22%2c%22operator%22%3a%22gte%22%2c%22property_value%22%3a.99%7d%2c%7b%22property_name%22%3a%22body%3aon_sale%22%2c%22operator%22%3a%22eq%22%2c%22property_value%22%3atrue%7d%5d

Finally, set the “filters” parameter in your query string equal to the URLencoded string.

Example:

.. code-block:: none

    https://api.keen.io/2.0/projects/<project_id>/<event_name>/_count?api_key=<api_key>&filters=%5b%7b%22property_name%22%3a%22body%3aprice%22%2c%22operator%22%3a%22gte%22%2c%22property_value%22%3a.99%7d%2c%7b%22property_name%22%3a%22body%3aon_sale%22%2c%22operator%22%3a%22eq%22%2c%22property_value%22%3atrue%7d%5d
