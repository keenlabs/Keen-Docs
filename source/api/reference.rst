
===========================
API Technical Reference
===========================

This document lists all of the technical resources available on Keen API. 

.. note:: This API is part of a developer preview and may change without notice!

Contents:

* :ref:`versions-resource` - Returns the available API versions.
* :ref:`discovery-resource` - Returns the available child resources. Currently, the only child resource is the Projects Resource.
* :ref:`projects-list-resource` - Returns the projects accessible to the API user, as well as links to project sub-resources for discovery.
* :ref:`project-row-resource` - Returns detailed information about the specific project, as well as links to related resources.
* :ref:`event-collections-list-resource` - Used for bulk inserting events or for getting information about all the collections in a given project.
* :ref:`event-collection-row-resource` - Used for inserting events or to get information about a specific event collection including properties and their type.
* :ref:`count-resource` - Returns a count of items meeting specified criteria.
* :ref:`count-unique-resource` - Returns a count of unique items meeting specified criteria.
* :ref:`minimum-resource` - Returns the minimum value for a given property.
* :ref:`maximum-resource` - Returns the maximum value for a given property.
* :ref:`average-resource` - Returns the average of all values for a given property.
* :ref:`sum-resource` - Returns the sum of all values for a given property.
* :ref:`select-unique-resource` - Returns a list of unique items meeting specified criteria.
* :ref:`extraction-resource` - Returns data meeting specified criteria.
* :ref:`progression-resource` - Returns a Progression. Read more about :doc:`/data_analysis/progressions`.
* :ref:`saved-query-list-resource` - Returns all the existing saved queries for the specific projects.
* :ref:`saved-query-row-resource` - Returns information about a single Saved Query. Also supports inserting a new Saved Query or updating an existing one.
* :ref:`saved-query-row-result-resource` - Returns the analysis results of a single Saved Query.

.. _versions-resource:

Versions Resource
=================

----
URL
----

https://api.keen.io/

-----------
Description
-----------

Returns the available API versions. Please only use API version 3.0. Versions 1.0 and 2.0 will work but will be deprecated shortly.

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  [
    {
      "is_public": false, 
      "url": "/1.0", 
      "version": "1.0"
    }, 
    {
      "is_public": false, 
      "url": "/2.0", 
      "version": "2.0"
    }, 
    {
      "is_public": true, 
      "url": "/3.0", 
      "version": "3.0"
    }
  ]

.. _discovery-resource:

Discovery Resource
==================

----
URL
----

https://api.keen.io/<version>

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

Returns the available child resources. Currently, the only child resource is the Projects Resource.

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
    "projects_resource_url": "/3.0/projects"
  }

.. _projects-list-resource:

Projects Resource
=================

----
URL
----

https://api.keen.io/<version>/projects

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

Returns the projects accessible to the API user, as well as links to project sub-resources for discovery.

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  [
    {
      "api_key": "a62538e817dd49fc9101fd0c1fa3c892", 
      "events": [
        {
          "name": "purchases", 
          "url": "/3.0/projects/4fea721933da5b4e8e000002/purchases"
        }, 
        {
          "name": "level_up", 
          "url": "/3.0/projects/4fea721933da5b4e8e000002/level_up"
        }, 
        {
          "name": "inventory_changes", 
          "url": "/3.0/projects/4fea721933da5b4e8e000002/inventory_changes"
        }, 
        {
          "name": "login", 
          "url": "/3.0/projects/4fea721933da5b4e8e000002/login"
        }
      ], 
      "events_url": "/3.0/projects/4fea721933da5b4e8e000002/events", 
      "id": "4fea721933da5b4e8e000002", 
      "saved_queries": [],
      "name": "Click to Buy (iOS)", 
      "queries_url": "/3.0/projects/4fea721933da5b4e8e000002/queries",
      "url": "/3.0/projects/4fea721933da5b4e8e000002"
    }
  ]

.. _project-row-resource:

Project Row Resource
====================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

Returns detailed information about the specific project, as well as links to related resources.

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
    "api_key": "a62538e817dd49fc9101fd0c1fa3c892", 
    "events": [
      {
        "name": "purchases", 
        "url": "/3.0/projects/4fea721933da5b4e8e000002/purchases"
      }, 
      {
        "name": "level_up", 
        "url": "/3.0/projects/4fea721933da5b4e8e000002/level_up"
      }, 
      {
        "name": "inventory_changes", 
        "url": "/3.0/projects/4fea721933da5b4e8e000002/inventory_changes"
      }, 
      {
        "name": "login", 
        "url": "/3.0/projects/4fea721933da5b4e8e000002/login"
      }
    ], 
    "events_url": "/3.0/projects/4fea721933da5b4e8e000002/events", 
    "id": "4fea721933da5b4e8e000002", 
    "saved_queries": [],
    "name": "Click to Buy (iOS)", 
    "queries_url": "/3.0/projects/4fea721933da5b4e8e000002/queries",
    "url": "/3.0/projects/4fea721933da5b4e8e000002"
  }
  
.. _event-collections-list-resource:

Event Collections List Resource
===============================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/events

-----------------
Supported Methods
-----------------

GET, HEAD, POST

-----------
Description
-----------

GET returns schema information for all the collections in this project, including properties and their type. It also returns links to sub-resources.

POST is for bulk-inserting multiple events in a single request. See below for examples.

.. note:: Make sure to set the request header "Content-Type" to "application/json" for POSTs.

----------------
GET Request Body
----------------

None

--------------------
Example GET Response
--------------------

.. code-block:: javascript

  [
    {
      "name": "purchases", 
      "properties": {
        "item.id": "num", 
        "item.on_sale": "bool", 
        "item.price": "num", 
        "quantity": "num", 
        "screen.category": "string", 
        "screen.name": "string", 
        "user.has_paid": "bool", 
        "user.id": "num", 
        "user.level": "num", 
        "user.prior_balance": "num", 
        "user.referring_source": "string"
      }, 
      "url": "/3.0/projects/4fea721933da5b4e8e000002/events/purchases"
    }, 
    {
      "name": "level_up", 
      "properties": {
        "from_level": "num", 
        "level": "num", 
        "screen.category": "string", 
        "screen.name": "string", 
        "to_level": "num", 
        "user.has_paid": "bool", 
        "user.id": "num", 
        "user.level": "num", 
        "user.prior_balance": "num", 
        "user.referring_source": "string"
      }, 
      "url": "/3.0/projects/4fea721933da5b4e8e000002/events/level_up"
    }, 
    {
      "name": "inventory_changes", 
      "properties": {
        "item.id": "num", 
        "quantity": "num", 
        "screen.category": "string", 
        "screen.name": "string", 
        "user.has_paid": "bool", 
        "user.id": "num", 
        "user.level": "num", 
        "user.prior_balance": "num", 
        "user.referring_source": "string"
      }, 
      "url": "/3.0/projects/4fea721933da5b4e8e000002/events/inventory_changes"
    }, 
    {
      "name": "login", 
      "properties": {
        "user.email": "string", 
        "user.id": "string", 
        "user_agent.browser": "string", 
        "user_agent.browser_version": "string", 
        "user_agent.platform": "string"
      }, 
      "url": "/3.0/projects/4fea721933da5b4e8e000002/events/login"
    }
  ]

--------------------------------------------------
POST Request Body - Example of batch event posting
--------------------------------------------------
This example shows how multiple JSON events can be sent to Keen in a single POST. The API expects a JSON object whose keys are the names of each event collection you want to insert into. Each key should point to a list of events to insert for that collection.

This example loads 3 events into the "purchases" event collection and 2 events into the "meme_generations" collection.

.. code-block:: javascript

  {
    "purchases": [
      {      
       	 "itemID": 22654,
		 "price": 455.65,
		 "color": "yellow",
		 "size": "gigantic",
		 "smell": "foul",
		 "taste": "salty"	  
      },
      {
         "itemID": 22634,
		 "price": 89.33,
		 "color": "fuschia",
		 "size": "medium",
		 "smell": "suspicious",
		 "taste": "milky"
       },
	   {
         "itemID": 22632,
		 "price": 3.51,
		 "color": "mauve",
		 "size": "medium",
		 "smell": "oregano",
		 "taste": "pepperoni"
    ],
    "meme_generations": [
       {
      	 "memeID": 226342
		 "character": "Futurama Fry"
		 "horribleness": "really horrible"
		 "text": "Not sure if example is useful ... or just confusing"
       },
	   {
         "memeID": 22632
		 "character": "Good Guy Greg",
		 "horribleness": "the worst.",
		 "text": "Finds error in Keen docs ... let's team@keen.io know about it"
       }
    ]
  }



--------------------------------------------------
POST Request Body - Example with custom timestamps
--------------------------------------------------

This example shows how you can overwrite Keen's timestamp by sending a keen.timestamp property value. By default, Keen clients will automatically set this time at the time your event is recorded. 

If you are not using one of our client libraries and you don't include this timestamp, Keen will automatically populate it at the time your event is received. 

See :ref:`property-types` for more information about the shape of event data in Keen. 

.. code-block:: javascript

  {
    "purchases": [
      {
        "keen": {
          	"timestamp": "2012-06-06T19:10:39.205000Z"
        },
        "quantity": 5
      },
      {
        "keen": {
          	"timestamp": "2012-06-06T20:10:39.205000Z"
        },
        "quantity": 25
      }
    ],
    "inventory_changes": [
      {
        "keen": {
          "timestamp": "2012-06-06T19:10:39.205000Z"
        },
        "quantity": 32
      },
      {
        "keen": {
          "timestamp": "2012-06-06T19:10:39.205000Z"
        },
        "quantity": 5
      }
    ]
  }

---------------------
Example POST Response
---------------------

.. code-block:: javascript

  {
    "purchases": [
      {
        "success": true
      }, 
      {
        "success": true
      }
    ], 
    "inventory_changes": [
      {
        "success": true
      },
      {
        "success": true
      } 
    ]
  }
  
.. _event-collection-row-resource:

Event Collection Row Resource
=============================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/events/<collection>

-----------------
Supported Methods
-----------------

GET, HEAD, POST

-----------
Description
-----------

GET returns available schema information for this event collection, including properties and their type. It also returns links to sub-resources.

POST is for inserting one event at a time in a single request. See below for examples.

.. note:: For performance gains, consider using bulk insert.

.. note:: Make sure to set the request header "Content-Type" to "application/json" for POSTs.

----------------
GET Request Body
----------------

None

--------------------
Example GET Response
--------------------

.. code-block:: javascript

  {
    "name": "purchases", 
    "properties": {
      "item.id": "num", 
      "item.on_sale": "bool", 
      "item.price": "num", 
      "quantity": "num", 
      "screen.category": "string", 
      "screen.name": "string", 
      "user.has_paid": "bool", 
      "user.id": "num", 
      "user.level": "num", 
      "user.prior_balance": "num", 
      "user.referring_source": "string"
    }, 
    "url": "/3.0/projects/4fea721933da5b4e8e000002/events/purchases"
  }

-----------------
POST Request Body
-----------------

See :ref:`event-data` for more information about the shape of event data in Keen.

.. code-block:: javascript

	{
		"keen": {
			"timestamp": "2012-06-06T19:10:39.205000Z"
		},
		"type": "mouse_click",
		"x_coord": 720,
		"y_coord": 640
	}

---------------------
Example POST Response
---------------------

.. code-block:: javascript

	{
		"created": true
	}

.. _queries-resource:

Queries Resource
=================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/queries

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns the list of available queries and links to them. See :doc:`/data_analysis/data_analysis` for more information.

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
    "count_unique_url": "/3.0/projects/4fea721933da5b4e8e000002/queries/count_unique",
    "count_url": "/3.0/projects/4fea721933da5b4e8e000002/queries/count",
    "extraction_url": "/3.0/projects/4fea721933da5b4e8e000002/queries/extraction",
    "progression_url": "/3.0/projects/4fea721933da5b4e8e000002/queries/progression",
    "select_unique_url": "/3.0/projects/4fea721933da5b4e8e000002/queries/select_unique"
  }

.. _count-resource:

Count Resource
==============

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/queries/count

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns the number of resources in the collection matching the given criteria. The response will be a simple JSON object with one key: a numeric result.

-----------------------
Query String Parameters
-----------------------

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. See :doc:`/data_analysis/authentication` for more information.
* **collection** (required) - The name of the event collection you are analyzing.
* **filters** (optional) - :doc:`/data_analysis/filters` are used to narrow down the events used in an analysis request based on `event property <event_properties>`_ values.
* **timeframe** (optional) - A :doc:`/data_analysis/timeframe` specifies the events to use for analysis based on a window of time. If no timeframe is specified, all events will be counted.

.. note:: Adding :doc:`/data_analysis/timeframe` and :doc:`/data_analysis/interval` query string parameters will turn the Count request into a Series.  See the documentation on :doc:`/data_analysis/series` for more information.

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
      "result": 10
  }


.. _count-unique-resource:

Count Unique Resource
=====================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/queries/count_unique

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns the number of UNIQUE resources in the collection matching the given criteria. The response will be a simple
JSON object with one key: result, which maps to the numeric result described previously.

-----------------------
Query String Parameters
-----------------------

.. include:: /data_analysis/metric_parameters.txt

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
    "result": 7
  }
  
.. _minimum-resource:

Minimum Resource
================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/queries/minimum

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns the minimum numeric value for the target property in the event collection matching the given criteria. Non-numeric values are ignored. The response will be a simple JSON object with one key: result, which maps to the numeric result described previously.

-----------------------
Query String Parameters
-----------------------

.. include:: /data_analysis/metric_parameters.txt

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
    "result": 7
  }

.. _maximum-resource:

Maximum Resource
================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/queries/maximum

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns the maximum numeric value for the target property in the event collection matching the given criteria. Non-numeric values are ignored. The response will be a simple JSON object with one key: result, which maps to the numeric result described previously.

-----------------------
Query String Parameters
-----------------------

.. include:: /data_analysis/metric_parameters.txt

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
    "result": 7
  } 
  
.. _average-resource:

Average Resource
================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/queries/average

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns the average across all numeric values for the target property in the event collection matching the given criteria. Non-numeric values are ignored. The response will be a simple JSON object with one key: result, which maps to the numeric result described previously.

-----------------------
Query String Parameters
-----------------------

.. include:: /data_analysis/metric_parameters.txt

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
    "result": 7
  }
  
.. _sum-resource:

Sum Resource
============

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/queries/sum

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns the sum of all numeric values for the target property in the event collection matching the given criteria. Non-numeric values are ignored. The response will be a simple JSON object with one key: result, which maps to the numeric result described previously.

-----------------------
Query String Parameters
-----------------------

.. include:: /data_analysis/metric_parameters.txt

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
    "result": 7
  }
    
.. _select-unique-resource:

Select Unique Resource
======================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/queries/select_unique

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns a list of UNIQUE resources in the collection matching the given criteria. The response will be a simple
JSON object with one key: result, which maps to the numeric result described previously.

-----------------------
Query String Parameters
-----------------------

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. See :doc:`/data_analysis/authentication` for more information.
* **collection** (required) - The name of the event collection you are analyzing.
* **target_property** (required) - The property of which you want to count the unique values.
* **filters** (optional) - :doc:`/data_analysis/filters` are used to narrow down the events used in an analysis request based on `event property <event_properties>`_ values.
* **timeframe** (optional) - Similar to filters, a :doc:`/data_analysis/timeframe` is used to narrow down the events used in an analysis request based on the time that the event occurred.

.. note:: Adding **timeframe** and **interval** query string parameters will turn the Select Unique request into a Series.  See the documentation on :doc:`Series</data_analysis/series>` for more information.

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

    {
        "result": ["hello", "goodbye", "welcome"]
    }

.. _extraction-resource:

Extraction Resource
===================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/queries/extractions

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET creates an extraction request. See :doc:`/data_analysis/extractions` for more details. If the query string parameter **email** is specified, then the extraction will be processed asynchronously and an e-mail will be sent to the specified address when it completes. If **email** is omitted, then the extraction will be processed in-line and the CSV results will be returned in the GET request.

-----------------------
Query String Parameters
-----------------------

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. See :doc:`/data_analysis/authentication` for more information.
* **collection** (required) - The name of the event collection you are analyzing.
* **filters** (optional) - :doc:`/data_analysis/filters` are used to narrow down the events used in an analysis request based on `event property <event_properties>`_ values.
* **timeframe** (optional) - Similar to filters, a :doc:`/data_analysis/timeframe` is used to narrow down the events used in an analysis request based on the time that the event occurred.

.. note:: :doc:`/data_analysis/series` are not supported for the Extraction Resource. The **interval** query string parameter is not used here.

------------
Request Body
------------

None

----------------
Example Response
----------------

GET (if **email** is specified)

::

  {"result": "Processing. Check the specified email for the extraction results."}

GET (if **email** is not specified)

::

  keen.timestamp,user.referring_source,user.has_paid,user.level,screen.category,item.price,item.id,user.id,quantity,user.prior_balance,screen.name,item.on_sale
  2012-07-11T05:08:05.352000,fb_ad_15,True,6,Shop,863,847,10,2,536,Equipment Store,False
  2012-07-11T05:08:06.284000,fb_ad_20,True,1,Shop,584,238,1,4,301,Equipment Store,False

.. _progression-resource:

Progression Resource
====================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/queries/progression

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

See :doc:`/data_analysis/progressions` for more details!

-----------------------
Query String Parameters
-----------------------

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. See :doc:`/data_analysis/authentication` for more information.
* **steps** (required) - A URL encoded JSON Array defining the :ref:`steps` in the Progression.

.. note:: :doc:`/data_analysis/series` are not supported for the Progression Resource. The **interval** query string parameter is not used here.

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
    "result": [
      2, 
      1
    ], 
    "steps": [
      {
        "actor_property": [
          "username"
        ], 
        "collection": "landed", 
        "filters": [
          {
            "operator": "eq", 
            "property_name": "device", 
            "property_value": "Android"
          }
        ]
      }, 
      {
        "actor_property": [
          "username"
        ], 
        "collection": "signed_up", 
        "filters": [
          {
            "operator": "eq", 
            "property_name": "device", 
            "property_value": "Android"
          }
        ]
      }
    ]
  }
  
.. _saved-query-list-resource:

Saved Queries List Resource
============================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/saved_queries

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns all the available Saved Queries for the specified project as well as links to child-resources.

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  [
    {
      "analysis_type": "count", 
      "created_date": "2012-09-14T22:23:50.259000", 
      "collection": "foo", 
      "filters": [], 
      "query_name": "query_one",
      "query_type": "metric",
      "interval": null, 
      "last_modified_date": "2012-09-14T22:23:50.259000", 
      "timeframe": null, 
      "urls": {
        "saved_query_results_url": "/3.0/projects/abc/saved_queries/query_one/result",
        "saved_query_url": "/3.0/projects/abc/saved_queries/query_one"
      }
    }, 
    {
      "analysis_type": "count", 
      "created_date": "2012-09-14T22:23:50.288000", 
      "collection": "bar", 
      "filters": [], 
      "query_name": "query_two",
      "query_type": "metric",
      "interval": null, 
      "last_modified_date": "2012-09-14T22:23:50.288000", 
      "timeframe": null, 
      "urls": {
        "saved_query_results_url": "/3.0/projects/abc/saved_queries/query_two/result",
        "saved_query_url": "/3.0/projects/abc/saved_queries/query_two"
      }
    }
  ]

.. _saved-query-row-resource:

Saved Query Row Resource
==========================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/saved_queries/<saved_query_name>

-----------------
Supported Methods
-----------------

GET, HEAD, PUT, DELETE

-----------
Description
-----------

GET returns information about the specified Saved Query and includes links to child-resources.

PUT either inserts a new Saved Query if it doesn't already exist, or updates an existing Saved Query if it does exist.

When inserting a new Saved Query, the body of the PUT request should be a JSON object with all the required properties for that particular analysis type. The optional properties, are, well, optional.

When updating a Saved Query, the body of the PUT request only needs to include the properties you want to update. For example, if you have a Saved Query that does a Count and want to change its :doc:`/data_analysis/filters`, just include the **filters** property.

.. note:: If you update a Saved Query's **analysis_type** and the NEW type doesn't allow for some of the properties of the OLD type, Keen will delete the definition of those properties. For example, if you have a Saved Query that does a Count Unique and you change it to do a Count, we will delete the **target_property** property.

.. note:: Make sure to set the request header "Content-Type" to "application/json" for PUTs.

DELETE just plain old deletes the Saved Query.

----------
Parameters
----------

.. include:: /data_analysis/saved_query_parameters.txt

----------------
GET Request Body
----------------

None

--------------------
Example GET Response
--------------------

.. code-block:: javascript

  {
    "analysis_type": "count", 
    "created_date": "2012-09-14T22:23:50.259000", 
    "collection": "foo", 
    "filters": [], 
    "query_name": "query_three",
    "query_type": "metric",
    "interval": null, 
    "last_modified_date": "2012-09-14T22:23:50.259000", 
    "timeframe": null, 
    "urls": {
      "saved_query_results_url": "/3.0/projects/abc/saved_queries/query_three/result",
      "saved_query_url": "/3.0/projects/abc/saved_queries/query_three"
    }
  }

-----------------
POST Request Body
-----------------

.. code-block:: javascript

	{
	  "analysis_type": "count", 
	  "collection": "foo"
	}

---------------------
Example POST Response
---------------------

.. code-block:: javascript

  {
    "created": true, 
    "saved_query": {
      "analysis_type": "count", 
      "created_date": "2012-09-14T22:23:50.259178", 
      "collection": "foo",
      "filters": [], 
      "query_name": "query_four",
      "query_type": "metric",
      "interval": null, 
      "last_modified_date": "2012-09-14T22:23:50.259178", 
      "timeframe": null, 
      "urls": {
        "saved_query_results_url": "/3.0/projects/abc/saved_queries/query_four/result",
        "saved_query_url": "/3.0/projects/abc/saved_queries/query_four"
      }
    }, 
    "updated": false
  }
  
.. _saved-query-row-result-resource:

Saved Query Row Result Resource
=================================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/saved_queries/<event_collection>/result

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns the results of the specified Saved Query.

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
    "result": 5
  }