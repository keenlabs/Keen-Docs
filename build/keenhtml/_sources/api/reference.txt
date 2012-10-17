
===========================
API Technical Reference
===========================

This document lists all of the technical resources available on Keen API. 

.. note:: This API is part of a developer preview and may change without notice!

Resource Inventory:

* :ref:`versions-resource` - Returns the available API versions.
* :ref:`discovery-resource` - Returns the available child resources.
* :ref:`projects-list-resource` - Returns the projects accessible to the API user, as well as links to project sub-resources for discovery.
* :ref:`project-row-resource` - Returns detailed information about the specific project, as well as links to related resources.
* :ref:`event-collections-list-resource` - Used for bulk inserting events or for getting information about all the collections in a given project.
* :ref:`event-collection-row-resource` - Used for inserting events or to get information about a specific event collection.
* :ref:`count-resource` - Returns a count of items meeting specified criteria.
* :ref:`count-unique-resource` - Returns a count of unique items meeting specified criteria.
* :ref:`minimum-resource` - Returns the minimum value for a given property.
* :ref:`maximum-resource` - Returns the maximum value for a given property.
* :ref:`average-resource` - Returns the average of all values for a given property.
* :ref:`sum-resource` - Returns the sum of all values for a given property.
* :ref:`select-unique-resource` - Returns a list of unique items meeting specified criteria.
* :ref:`extraction-resource` - Returns data meeting specified criteria.
* :ref:`progression-resource` - Returns a Progression. Read more about :doc:`/data-analysis/progressions`.
* :ref:`saved-query-list-resource` - Returns all the existing saved queries for the specific projects.
* :ref:`saved-query-row-resource` - Returns information about a single Saved Query. Also supports inserting a new Saved Query or updating an existing one.
* :ref:`saved-query-row-result-resource` - Returns the analysis results of a single Saved Query.

.. _versions-resource:

Versions Resource
==================


+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/                                                                                                                       | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | Returns the available API versions. Please only use API version 3.0. Versions 1.0 and 2.0 will work but will be deprecated shortly.        |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                  |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+


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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>                                                                                                              | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | Returns the available child resources. Currently, the only child resource is the Projects Resource.                                        |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                  |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+


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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects                                                                                                     | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | Returns the projects accessible to the API user, as well as links to project sub-resources for discovery.                                  |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                  |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+


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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>                                                                                        | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | Returns detailed information about the specific project, as well as links to related resources.                                            |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                  |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------+


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

+-------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/events/                                                                                                 | 
+-------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | | GET returns schema information for all the event collections in this project, including properties and their type. It also returns links to sub-resources.|
|                   | | POST is for inserting multiple events in one or more collections, in a single request. See below for examples.                                            |
+-------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD, POST                                                                                                                                             |
+-------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------+
| POST Request Body | JSON arrays of events. See example below                                                                                                                    |
+-------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------+


.. note:: Make sure to set the request header "Content-Type" to "application/json" for POSTs.


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
This example shows how multiple JSON events can be sent to Keen in a single POST. The API expects a JSON object whose keys are the names of each event collection you want to insert into. Each key should point to a list of events to insert for that event collection.

This example loads 3 events into the "purchases" event collection and 2 events into the "meme_generations" event collection.


.. note:: Make sure to set the request header "Content-Type" to "application/json" for POSTs.

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

+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/events/<event_collection>                                                                      | 
+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | | GET returns available schema information for this event collection, including properties and their type. It also returns links to sub-resources. |
|                   | | POST is for inserting one event at a time in a single request. Examples below.                                                                   |
+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD, POST                                                                                                                                    |
+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| POST Request Body | Single JSON event. See example below                                                                                                               |
+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+




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

+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/queries                                                                                        | 
+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | GET returns the list of available queries and links to them. See :doc:`/data-analysis/index` for more information on query types.                  |
+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                          |
+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------------+


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

+-------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/queries/count                                                                                                           | 
+-------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | GET returns the number of resources in the event collection matching the given criteria. The response will be a simple JSON object with one key: a numeric result.          |
+-------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                                                   |
+-------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+


-----------------------
Query String Parameters
-----------------------

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. See :doc:`/data-analysis/authentication` for more information.
* **event_collection** (required) - The name of the event collection you are analyzing.
* **filters** (optional) - :doc:`/data-analysis/filters` are used to narrow down the events used in an analysis request based on `event property <event_properties>`_ values.
* **timeframe** (optional) - A :doc:`/data-analysis/timeframe` specifies the events to use for analysis based on a window of time. If no timeframe is specified, all events will be counted.

.. note:: Adding :doc:`/data-analysis/timeframe` and :doc:`/data-analysis/interval` query string parameters will turn the Count request into a Series.  See the documentation on :doc:`/data-analysis/series` for more information.

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

+-------------------+-------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/queries/count_unique                                                      | 
+-------------------+-------------------------------------------------------------------------------------------------------------------------------+
| Description       | GET returns the number of UNIQUE resources in the event collection matching the given criteria.                               |
|                   | The response will be a simple JSON object with one key: result, which maps to the numeric result described previously.        |
+-------------------+-------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                     |
+-------------------+-------------------------------------------------------------------------------------------------------------------------------+


-----------------------
Query String Parameters
-----------------------

.. include:: /data-analysis/metric-parameters.txt


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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/queries/minimum                                                                                    | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | GET returns the minimum numeric value for the target property in the event collection matching the given criteria.                                     |
|                   | Non-numeric values are ignored. The response will be a simple JSON object with one key: result, which maps to the numeric result described previously. |
|                   | The response will be a simple JSON object with one key: result, which maps to the numeric result described previously.                                 |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                              |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+


-----------------------
Query String Parameters
-----------------------

.. include:: /data-analysis/metric-parameters.txt


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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/queries/maximum                                                                                    | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | GET returns the maximum numeric value for the target property in the event collection matching the given criteria.                                     |
|                   | Non-numeric values are ignored. The response will be a simple JSON object with one key: result, which maps to the numeric result described previously. |
|                   | The response will be a simple JSON object with one key: result, which maps to the numeric result described previously.                                 |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                              |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+



-----------------------
Query String Parameters
-----------------------

.. include:: /data-analysis/metric-parameters.txt


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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/queries/average                                                                                    | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | GET returns the average across all numeric values for the target property in the event collection matching the given criteria.                         |
|                   | Non-numeric values are ignored. The response will be a simple JSON object with one key: result, which maps to the numeric result described previously. |
|                   | The response will be a simple JSON object with one key: result, which maps to the numeric result described previously.                                 |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                              |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+



-----------------------
Query String Parameters
-----------------------

.. include:: /data-analysis/metric-parameters.txt


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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/queries/sum                                                                                        | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | GET returns the sum of all numeric values for the target property in the event collection matching the given criteria.                                 |
|                   | Non-numeric values are ignored. The response will be a simple JSON object with one key: result, which maps to the numeric result described previously. |
|                   | The response will be a simple JSON object with one key: result, which maps to the numeric result described previously.                                 |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                              |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+

-----------------------
Query String Parameters
-----------------------

.. include:: /data-analysis/metric-parameters.txt


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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/queries/select_unique                                                                              | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | GET returns a list of UNIQUE resources in the event collection matching the given criteria.                                                            |
|                   | The response will be a simple JSON object with one key: result, which maps to an array of unique property values.                                      |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                              |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+


-----------------------
Query String Parameters
-----------------------

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. If you don't include it as a query string parameter you must include it in the header. See :doc:`/data-analysis/authentication` for more information.
* **event_collection** (required) - The name of the event collection you are analyzing.
* **target_property** (required) - The property of which you want to count the unique values.
* **filters** (optional) - :doc:`/data-analysis/filters` are used to narrow down the events used in an analysis request based on `event property <event_properties>`_ values.
* **timeframe** (optional) - Similar to filters, a :doc:`/data-analysis/timeframe` is used to narrow down the events used in an analysis request based on the time that the event occurred.

.. note:: Adding **timeframe** and **interval** query string parameters will turn the Select Unique request into a Series.  See the documentation on :doc:`Series</data-analysis/series>` for more information.


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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/queries/extraction                                                                                                               | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | | GET creates an extraction request for full-form event data with all property values. See :doc:`/data-analysis/extractions` for more details.                                       |
|                   | | If the query string parameter **email** is specified, then the extraction will be processed asynchronously and an e-mail will be sent to the specified address when it completes.  |
|                   | | The email will include a link to a downloadable CSV file.                                                                                                                          |
|                   | | If **email** is omitted, then the extraction will be processed in-line and JSON results will be returned in the GET request.                                                       |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                                                            |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

-----------------------
Query String Parameters
-----------------------

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. See :doc:`/data-analysis/authentication` for more information.
* **event_collection** (required) - The name of the event collection you are analyzing.
* **filters** (optional) - :doc:`/data-analysis/filters` are used to narrow down the events used in an analysis request based on `event property <event_properties>`_ values.
* **timeframe** (optional) - Similar to filters, a :doc:`/data-analysis/timeframe` is used to narrow down the events used in an analysis request based on the time that the event occurred.
* **email_address** (optional) - If an email address is specified, an email will be sent to this address when the extraction is complete.

.. note:: :doc:`/data-analysis/series` are not supported for the Extraction Resource. The **interval** query string parameter is not used here.



----------------
Example Response
----------------

GET (if **email** is specified)

::

  {"result": "Processing. Check the specified email for the extraction results."}

GET (if **email** is not specified)

::

    [{
        "keen": {
            "timestamp": "2012-06-06T19:10:39.205000"
        },
        "item": "old rusty key with french words on it",
        "cost": 330.23,
        "payment_method": "Cash",
        "customer": {
            "name": "Shelby Frothsworth",
            "age": 22,
        },
        "store": {
            "name": "Yupster Things",
            "city": "San Francisco",
            "address": "467 West Portal Ave",
        }
    },
    {
        "keen": {
            "timestamp": "2012-06-07T13:10:35.203000"
        },
        "item": "sophisticated orange turtleneck with deer on it",
        "cost": 469.5,
        "payment_method": "Bank Simple VISA",
        "customer": {
            "name": "Francis Woodbury",
            "age": 28,
        },
        "store": {
            "name": "Yupster Things",
            "city": "San Francisco",
            "address": "467 West Portal Ave",
        }
    },
    {
        "keen": {
            "timestamp": "2012-06-07T13:10:35.203000"
        },
        "item": "antique gumball machine filled with marbles",
        "cost": 65.00,
        "payment_method": "Amex",
        "customer": {
            "name": "Izzy Graybeard",
            "age": 31,
        },
        "store": {
            "name": "Yupster Things",
            "city": "San Francisco",
            "address": "467 West Portal Ave",
        }
    }]



.. _progression-resource:

Progression Resource
====================

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/queries/progression                                                                                                              | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | Progressions count relevant events in succession. See :doc:`/data-analysis/progressions` for more details!                                                                           |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                                                            |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+


-----------------------
Query String Parameters
-----------------------

* **api_key** (optional) - The API Key for the project containing the data you are analyzing. If you don't include it as a query string parameter you must include it in the header. See :doc:`/data-analysis/authentication` for more information.
* **steps** (required) - A URL encoded JSON Array defining the :ref:`steps` in the Progression.

.. note:: :doc:`/data-analysis/series` are not supported for the Progression Resource. The **interval** query string parameter is not used here.


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
        "event_collection": "landed", 
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
        "event_collection": "signed_up", 
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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/saved_queries                                                                                                                    | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | GET returns all the available Saved Queries for the specified project as well as links to child-resources.                                                                           |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                                                            |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+


-----------------------
Query String Parameters
-----------------------

* **api_key**  - The API Key for the project containing the data you are analyzing. If you don't include it as a query string parameter you must include it in the header. See :doc:`/data-analysis/authentication` for more information.

----------------
Example Response
----------------

.. code-block:: javascript

  [
    {
      "analysis_type": "count", 
      "created_date": "2012-09-14T22:23:50.259000", 
      "event_collection": "foo", 
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
      "event_collection": "bar", 
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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/saved_queries/<saved_query_name>                                                                                                 | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | | GET returns information about the specified Saved Query and includes links to child-resources.                                                                                     |
|                   | | PUT either inserts a new Saved Query if it doesn't already exist, or updates an existing Saved Query if it does exist.                                                             |
|                   | | DELETE just plain old deletes the Saved Query.                                                                                                                                     |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD, PUT, DELETE                                                                                                                                                               |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+


-----
Notes
-----

When inserting a new Saved Query, the body of the PUT request should be a JSON object with all the required properties for that particular analysis type. The optional properties, are, well, optional.

When updating a Saved Query, the body of the PUT request only needs to include the properties you want to update. For example, if you have a Saved Query that does a Count and want to change its :doc:`/data-analysis/filters`, just include the **filters** property.

.. note:: If you update a Saved Query's **analysis_type** and the NEW type doesn't allow for some of the properties of the OLD type, Keen will delete the definition of those properties. For example, if you have a Saved Query that does a Count Unique and you change it to do a Count, we will delete the **target_property** property.

.. note:: Make sure to set the request header "Content-Type" to "application/json" for PUTs.



-----------------------
Query String Parameters
-----------------------

.. include:: /data-analysis/saved-query-parameters.txt



--------------------
Example GET Response
--------------------

.. code-block:: javascript

  {
    "analysis_type": "count", 
    "created_date": "2012-09-14T22:23:50.259000", 
    "event_collection": "foo", 
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
PUT Request Body
-----------------

.. code-block:: javascript

	{
	  "analysis_type": "count", 
	  "event_collection": "foo"
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
      "event_collection": "foo",
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

+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| URL               | https://api.keen.io/<version>/projects/<project_id>/saved_queries/<event_collection>/result                                                                                          | 
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Description       | GET returns the results of the specified Saved Query.                                                                                                                                |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Supported Methods | GET, HEAD                                                                                                                                                                            |
+-------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+



----------------
Example Response
----------------

.. code-block:: javascript

  {
    "result": 5
  }
