
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
* :ref:`event-collections-list-resource` - Returns collection info including properties and their type. It also returns links to sub-resources. Also used for posting events.
* :ref:`event-collection-row-resource` - Returns info about this specific event collection including properties and their type.
* :ref:`count-resource` - Returns a count of items meeting specified criteria.
* :ref:`count-unique-resource` - Returns a count of unique items meeting specified criteria.
* :ref:`minimum-resource` - Returns the minimum value for a given property.
* :ref:`maximum-resource` - Returns the maximum value for a given property.
* :ref:`average-resource` - Returns the average of all values for a given property.
* :ref:`sum-resource` - Returns the sum of all values for a given property.
* :ref:`select-unique-resource` - Returns a list of unique items meeting specified criteria.
* :ref:`extraction-resource` - Returns data meeting specified criteria.
* :ref:`progression-resource` - Returns a Progression. Read more about :doc:`/data_analysis/progressions`.
* :ref:`saved-insights-list-resource` - Returns all the existing saved insights for the specific projects.
* :ref:`saved-insight-row-resource` - Returns information about a single saved insight. Also supports inserting a new saved insight or updating an existing one.
* :ref:`saved-insight-row-result-resource` - Returns the analysis results of a single saved insight.

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
      "insights": [], 
      "name": "Click to Buy (iOS)", 
      "probes_url": "/3.0/projects/4fea721933da5b4e8e000002/probes", 
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
    "insights": [], 
    "name": "Click to Buy (iOS)", 
    "probes_url": "/3.0/projects/4fea721933da5b4e8e000002/probes", 
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
        "body:item:id": "num", 
        "body:item:on_sale": "bool", 
        "body:item:price": "num", 
        "body:quantity": "num", 
        "body:screen:category": "string", 
        "body:screen:name": "string", 
        "body:user:has_paid": "bool", 
        "body:user:id": "num", 
        "body:user:level": "num", 
        "body:user:prior_balance": "num", 
        "body:user:referring_source": "string"
      }, 
      "url": "/3.0/projects/4fea721933da5b4e8e000002/events/purchases"
    }, 
    {
      "name": "level_up", 
      "properties": {
        "body:from_level": "num", 
        "body:level": "num", 
        "body:screen:category": "string", 
        "body:screen:name": "string", 
        "body:to_level": "num", 
        "body:user:has_paid": "bool", 
        "body:user:id": "num", 
        "body:user:level": "num", 
        "body:user:prior_balance": "num", 
        "body:user:referring_source": "string"
      }, 
      "url": "/3.0/projects/4fea721933da5b4e8e000002/events/level_up"
    }, 
    {
      "name": "inventory_changes", 
      "properties": {
        "body:item:id": "num", 
        "body:quantity": "num", 
        "body:screen:category": "string", 
        "body:screen:name": "string", 
        "body:user:has_paid": "bool", 
        "body:user:id": "num", 
        "body:user:level": "num", 
        "body:user:prior_balance": "num", 
        "body:user:referring_source": "string"
      }, 
      "url": "/3.0/projects/4fea721933da5b4e8e000002/events/inventory_changes"
    }, 
    {
      "name": "login", 
      "properties": {
        "body:user:email": "string", 
        "body:user:id": "string", 
        "body:user_agent:browser": "string", 
        "body:user_agent:browser_version": "string", 
        "body:user_agent:platform": "string"
      }, 
      "url": "/3.0/projects/4fea721933da5b4e8e000002/events/login"
    }
  ]

-----------------
POST Request Body
-----------------

See :ref:`event-data` for more information about the shape of event data in Keen. The API expects a JSON object whose keys are the names of each event collection you want to insert into. Each key should point to a list of events to insert for that collection.

.. code-block:: javascript

  {
    "purchases": [
      {
        "header": {
          "timestamp": "2012-06-06T19:10:39.205000Z"
        },
        "body": {
          "quantity": 5
        }
      },
      {
        "header": {
          "timestamp": "2012-06-06T20:10:39.205000Z"
        },
        "body": {
          "quantity": 25
        }
      }
    ],
    "inventory_changes": [
      {
        "header": {
          "timestamp": "2012-06-06T19:10:39.205000Z"
        },
        "body": {
          "quantity": 32
        }
      },
      {
        "header": {
          "timestamp": "2012-06-06T19:10:39.205000Z"
        },
        "body": {
          "quantity": 5
        }
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

https://api.keen.io/<version>/projects/<project_id>/events/<event_name>

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
      "body:item:id": "num", 
      "body:item:on_sale": "bool", 
      "body:item:price": "num", 
      "body:quantity": "num", 
      "body:screen:category": "string", 
      "body:screen:name": "string", 
      "body:user:has_paid": "bool", 
      "body:user:id": "num", 
      "body:user:level": "num", 
      "body:user:prior_balance": "num", 
      "body:user:referring_source": "string"
    }, 
    "url": "/3.0/projects/4fea721933da5b4e8e000002/events/purchases"
  }

-----------------
POST Request Body
-----------------

See :ref:`event-data` for more information about the shape of event data in Keen.

.. code-block:: javascript

	{
		"header": {
			"timestamp": "2012-06-06T19:10:39.205000Z"
		},
		"body": {
			"type": "mouse_click",
			"x_coord": 720,
			"y_coord": 640
		}
	}

---------------------
Example POST Response
---------------------

.. code-block:: javascript

	{
		"created": true
	}

.. _probes-resource:

Probes Resource
===============

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/probes

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns the list of available probes and links to them. See :doc:`/data_analysis/data_analysis` for more information.

------------
Request Body
------------

None

----------------
Example Response
----------------

.. code-block:: javascript

  {
    "count_unique_url": "/3.0/projects/4fea721933da5b4e8e000002/probes/count_unique", 
    "count_url": "/3.0/projects/4fea721933da5b4e8e000002/probes/count", 
    "extraction_url": "/3.0/projects/4fea721933da5b4e8e000002/probes/extraction", 
    "progression_url": "/3.0/projects/4fea721933da5b4e8e000002/probes/progression", 
    "select_unique_url": "/3.0/projects/4fea721933da5b4e8e000002/probes/select_unique"
  }

.. _count-resource:

Count Resource
==============

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/probes/count

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
* **event_name** (required) - The name of the event collection you are analyzing.
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

https://api.keen.io/<version>/projects/<project_id>/probes/count_unique

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

https://api.keen.io/<version>/projects/<project_id>/probes/minimum

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

https://api.keen.io/<version>/projects/<project_id>/probes/maximum

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

https://api.keen.io/<version>/projects/<project_id>/probes/average

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

https://api.keen.io/<version>/projects/<project_id>/probes/sum

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

https://api.keen.io/<version>/projects/<project_id>/probes/select_unique

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
* **event_name** (required) - The name of the event collection you are analyzing.
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

https://api.keen.io/<version>/projects/<project_id>/probes/extractions

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
* **event_name** (required) - The name of the event collection you are analyzing.
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

  header.timestamp,user.referring_source,user.has_paid,user.level,screen.category,item.price,item.id,user.id,quantity,user.prior_balance,screen.name,item.on_sale
  2012-07-11T05:08:05.352000,fb_ad_15,True,6,Shop,863,847,10,2,536,Equipment Store,False
  2012-07-11T05:08:06.284000,fb_ad_20,True,1,Shop,584,238,1,4,301,Equipment Store,False

.. _progression-resource:

Progression Resource
====================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/probes/progression

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
    "results": [
      2, 
      2
    ], 
    "steps": [
      {
        "actor_property": [
          "body:username"
        ], 
        "event_name": "landed", 
        "filters": [
          {
            "operator": "eq", 
            "property_name": "body:device", 
            "property_value": "Android"
          }
        ]
      }, 
      {
        "actor_property": [
          "body:username"
        ], 
        "event_name": "signed_up", 
        "filters": [
          {
            "operator": "eq", 
            "property_name": "body:device", 
            "property_value": "Android"
          }
        ]
      }
    ]
  }
  
.. _saved-insights-list-resource:

Saved Insights List Resource
============================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/insights

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns all the available saved insights for the specified project as well as links to child-resources.

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
      "event_name": "foo", 
      "filters": [], 
      "insight_name": "insight_one", 
      "insight_type": "metric", 
      "interval": null, 
      "last_modified_date": "2012-09-14T22:23:50.259000", 
      "timeframe": null, 
      "urls": {
        "insight_results_url": "/3.0/projects/abc/insights/insight_one/results", 
        "insight_url": "/3.0/projects/abc/insights/insight_one"
      }
    }, 
    {
      "analysis_type": "count", 
      "created_date": "2012-09-14T22:23:50.288000", 
      "event_name": "bar", 
      "filters": [], 
      "insight_name": "insight_two", 
      "insight_type": "metric", 
      "interval": null, 
      "last_modified_date": "2012-09-14T22:23:50.288000", 
      "timeframe": null, 
      "urls": {
        "insight_results_url": "/3.0/projects/abc/insights/insight_two/results", 
        "insight_url": "/3.0/projects/abc/insights/insight_two"
      }
    }
  ]

.. _saved-insight-row-resource:

Saved Insight Row Resource
==========================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/insights/<insight_name>

-----------------
Supported Methods
-----------------

GET, HEAD, PUT, DELETE

-----------
Description
-----------

GET returns information about the specified saved insight and includes links to child-resources.

PUT either inserts a new saved insight if it doesn't already exist, or updates an existing insight if it does exist.

When inserting a new saved insight, the body of the PUT request should be a JSON object with all the required properties for that particular analysis type. The optional properties, are, well, optional.

When updating a saved insight, the body of the PUT request only needs to include the properties you want to update. For example, if you have a saved insight that does a Count and want to change its :doc:`/data_analysis/filters`, just include the **filters** property.

.. note:: If you update a saved insight's **analysis_type** and the NEW type doesn't allow for some of the properties of the OLD type, Keen will delete the definition of those properties. For example, if you have an insight that does a Count Unique and you change it to do a Count, we will delete the **target_property** property.

.. note:: Make sure to set the request header "Content-Type" to "application/json" for PUTs.

DELETE just plain old deletes the insight.

----------
Parameters
----------

.. include:: /data_analysis/saved_insight_parameters.txt

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
    "event_name": "foo", 
    "filters": [], 
    "insight_name": "insight_one", 
    "insight_type": "metric", 
    "interval": null, 
    "last_modified_date": "2012-09-14T22:23:50.259000", 
    "timeframe": null, 
    "urls": {
      "insight_results_url": "/3.0/projects/abc/insights/insight_one/results", 
      "insight_url": "/3.0/projects/abc/insights/insight_one"
    }
  }

-----------------
POST Request Body
-----------------

.. code-block:: javascript

	{
	  "analysis_type": "count", 
	  "event_name": "foo"
	}

---------------------
Example POST Response
---------------------

.. code-block:: javascript

  {
    "created": true, 
    "insight": {
      "analysis_type": "count", 
      "created_date": "2012-09-14T22:23:50.259178", 
      "event_name": "foo", 
      "filters": [], 
      "insight_name": "insight_one", 
      "insight_type": "metric", 
      "interval": null, 
      "last_modified_date": "2012-09-14T22:23:50.259178", 
      "timeframe": null, 
      "urls": {
        "insight_results_url": "/3.0/projects/abc/insights/insight_one/results", 
        "insight_url": "/3.0/projects/abc/insights/insight_one"
      }
    }, 
    "updated": false
  }
  
.. _saved-insight-row-result-resource:

Saved Insight Row Result Resource
=================================

----
URL
----

https://api.keen.io/<version>/projects/<project_id>/insights/<event_name>/results

-----------------
Supported Methods
-----------------

GET, HEAD

-----------
Description
-----------

GET returns the results of the specified saved insight.

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