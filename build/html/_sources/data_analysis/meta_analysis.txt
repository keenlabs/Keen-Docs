===================
Meta Analysis Tools
===================
These tools can be used to get information about your projects, event collections, Saved Queries, etc.

* :ref:`versions-resource` - The entry point to our APIs. Returns the available API versions and links to the :ref:`discovery-resource`.
* :ref:`discovery-resource` - Returns the available child resources. Currently, the only child resource is the :ref:`projects-list-resource`.
* :ref:`projects-list-resource` - Returns the projects accessible to the API user, as well as links to the :ref:`project-row-resource` for discovery.
* :ref:`project-row-resource` - Returns detailed information about the specific project, as well as links to related resources.
* :ref:`event-collections-list-resource` - Returns detailed information about all the event collections in the specific project, as well as links to them. Also used for bulk-inserting events.
* :ref:`event-collection-row-resource` - Returns event collection info including properties and their type. It also returns links to sub-resources. Also used for inserting events.
* :ref:`queries-resource` - Returns links to the available Queries, i.e. :doc:`metrics`, :doc:`progressions`, :doc:`extractions`.
* :ref:`saved-query-list-resource` - Returns all the available :doc:`saved_queries` in this project as well as links to each of their :ref:`saved-query-row-resource`.
