==============
Authentication
==============

Keen supports two mechanisms for authenticating API requests. For both of them, you'll need to know one key piece of information: the API Key for the Project you want to use. This is easily retrievable from the Keen UI. Login with your username and password to Keen_. Navigate to your project, make sure the "Project Overview" tab is selected, and you should see your API Key. Now that you have your API Key, let's talk about how you actually authenticate your requests.   

-----------
HTTP Header
-----------

The first way to authenticate is through a HTTP header called "Authorization". This method is supported for EVERY API call, so it will always work. To use it, simply send a HTTP header with your request. Its name should be "Authorization" and its value should just be your API Key. That's all you have to do.

------------------
Query String Param
------------------

The second way to authenticate is through a query string parameter called "api_key". Its value should just be your API Key.

.. note:: This mechanism for authentication is ONLY supported for the :ref:`data-analysis`. We support this so that links to analysis results can be embedded in HTML documents as links.

.. _Keen: https://keen.io
