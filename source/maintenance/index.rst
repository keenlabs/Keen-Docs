.. _maintenance:

===========
Maintenance
===========

This page describes some of the maintenance functions of the Keen IO API.

* :ref:`projects-maintenance` 
* :ref:`event-collections-maintenance`
* :ref:`event-properties-maintenance`


.. _projects-maintenance:

Projects
========

Technical Reference: :ref:`projects-resource`

You can create and delete projects on the Keen IO `projects page <https://keen.io/projects>`_.
Deleting your project puts your project in an inactive state and removes it from the UI.

You can also use our API to get information about your projects:

The :ref:`projects-resource` returns the projects accessible to the API user, as well as links to project sub-resources for discovery.

The :ref:`project-row-resource` returns detailed information about the specific project, as well as links to related resources.



.. _event-collections-maintenance:

Event Collections
=================

Technical Reference: :ref:`event-collection-resource`

After testing, you may have some event collections you want to delete. You do this using the `projects page <https://keen.io/projects>`_, or our API.

Deletion will only work for collections with under 10,000 events. If you need to delete a larger collection, we can help, just `let us know <team@keen.io>`_

Here's what an event collection request would look like using the REST API (use the DELETE method):

::

	https://api.keen.io/3.0/projects/<project_id>/events/<collection_name>?api_key=<key>
	    
Successful Result: 

::

    204 - No Content

You can also use a GET request to retrieve information about the event properties in your collection. For example:

::

    {
        "properties": {
            "user.age": "num",
            "user.name": "string",
            "user.location": "string",
        }
    }


.. _event-properties-maintenance:

Event Properties
================

Technical Reference: :ref:`event-properties`

Individual event properties can be deleted using our API. Deletion will only work for properties with under 10,000 events. If you need to delete more than that, `let us know <team@keen.io>`_

Here's an example event property DELETE request using the REST API:

::

	https://api.keen.io/3.0/projects/<project_id>/events/<event_collection>/properties/<property_name>?api_key=<key>
	    
Successful Result: 

::

    204 - No Content


You can also perform a GET request to retrieve information about a property:

:: 

    https://api.keen.io/3.0/projects/4fdf5ae25f546f1b6a000002/events/<event_collection>/properties/<property_name>?api_key=<key>

Result:

::

    {
        "property_name": "user.email",
        "url": "/3.0/projects/<project_id>/events/<event_collection>/properties/<property_name>",
        "type": "string"
    }
