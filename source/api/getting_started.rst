===============
Getting Started
===============

.. note:: This API is part of a developer preview and may change without notice!

.. note:: We recognize that changing APIs on you is really shitty, so while we’ll do it when in developer preview, we’ll never ever do it once the developer preview is over.

This guide is a tutorial / quick-start to get you up and running with the Keen API. After you’re done with this guide, you’ll have learned how to:

* :ref:`Authenticate the API requests you make <authentication>`
* :ref:`Insert a single event at a time <single_event_insert>`
* :ref:`Get the names of keys and the types of their values for the events you’ve already stored <collection_schema>`
* :ref:`Create an extraction request <create_extraction>`
* :ref:`Get the results of that extraction <get_extraction>`
* :ref:`Count the number of times an event has occurred <count>`

If you’re looking for the Keen Service API Reference Documentation, go :doc:`here<reference>`. It's great if what you want to see is a list of resources and example payloads!

Setup / Pre-requisites
======================
This guide assumes you already have an account to use Keen. If not, sign up for our
developer preview on our website, tweet us at `@keen_io <http://twitter.com/keen_io>`_, or e-mail us at `team@keen.io <mailto:team@keen.io>`_.
We suggest creating a new test :doc:`project </api/usage/projects>` in Keen so you don’t fill your real project with
test data (if you accidentally do, let us know - we can help).

This guide uses the command line tool cURL to issue HTTP requests. Most systems have
package managers that can install it for you (if it’s not installed already). Or you can
download it from http://curl.haxx.se/. Make sure that you can use curl from the command
line!

We also assume you know how to use a command line shell. You should be able to follow
along if you don’t know how to use one, but knowing how will mean you can actually try the
examples yourself!

Glossary
========
:doc:`Project </api/usage/projects>`: The Keen project that you want to use!

Collection: A :ref:`collection <event collections>` is logically like a table - it contains an arbitrary number of similarly typed events.

Event: An :doc:`event </api/usage/events_and_event_data>` is a  discrete piece of data that you want to track. Its shape is arbitrary JSON.


.. _authentication:

Authentication
==============
Authentication for our API is very simple. You need one piece of information: the API Key for whatever Project you want to use. This is easily retrieved from the Keen website. Login, then click on "Projects", then click on the name of the Project you wish to work with. You’ll be presented with a page that includes both the Project ID and the API Key for that Project.

All you have to do to authenticate is include the API Token in an HTTP header called "Authorization". It looks like:

::

    "Authorization": "<YOUR_API_KEY_HERE>"

An example using cURL:

-------
Request
-------

::

    curl https://api.keen.io -H "Authorization: <YOUR_API_KEY_HERE>"

--------
Response
--------

::

    [
       {
          "url":"\/beta",
          "is_public":false,
          "version":"beta"
       },
       {
          "url":"\/1.0",
          "is_public":false,
          "version":"1.0"
       },
       {
          "url":"\/2.0",
          "is_public":true,
          "version":"2.0"
       }
    ]

It’s as simple as that!

.. _single_event_insert:

Single Event Insert
===================

Now that you know how to authenticate an API request, inserting a new event into your project is very simple. You need to know your Project ID (see the first paragraph of the Authentication section above) and the name of the :ref:`Event Collection <event collections>` that you want to insert into. For this example, we’ll call our Collection "user_interactions", but you can pick almost any name!

So we’ll insert a new "user_interaction" event into our project. The event looks like this:

::

    {
        "body": {
            "type": "mouse_click",
            "x_coord": 720,
            "y_coord": 640
        }
    }

Save that JSON to a file on your filesystem. We’re naming ours "click1.json". Now, to send it to Keen, type the following: 

::

    curl https://api.keen.io/2.0/projects/<PROJECT_ID>/user_interactions
      -H "Authorization: <API_KEY>"
      -H "Content-Type: application/json"
      -d @click1.json

There are a couple things going on here. First, we send the request to a URL that includes both the Project ID and the name of the collection we want to insert into. Second, we set headers for both authorization and content-type (so the API knows it’s getting a JSON request). Third, we tell curl to set the body of the HTTP request to the contents of the file that we saved.

The response should look like:  

::

    {
        "created": true
    }

Once you see that, you’ve successfully inserted your event! 

.. _collection_schema:

Get Collection Schema Information
=================================

Once you’ve inserted a number of events, you may want to see the names of the keys in those events as well as the types of their values. This is useful if you want to create new extraction requests (so you can actually use the data you’re collecting!). Let’s get the schema for our "user_interactions" collection. It’s super easy:

-------
Request
-------

::

    curl https://api.keen.io/2.0/projects/<PROJECT_ID>/user_interactions -H "Authorization: <API_KEY>"

--------
Response
--------

::

    {
        "properties": [
            "body:y_coord",
            "body:type",
            "body:x_coord"
        ],
        "body:y_coord": {
            "num_appearances": 1,
            "type_appearances": {
                "num": 1
            }
        },
        "body:x_coord": {
            "num_appearances": 1,
            "type_appearances": {
                "num": 1
            }
        },
        "body:inferred_column_types": {
            "y_coord": "num",
            "type": "string",
            "x_coord": "num"
        },
        "body:type": {
            "num_appearances": 1,
            "type_appearances": {
                "string": 1
            }
        }
    }

The response has a few important bits. First, there’s a list of all the keys / column names under the property "properties". Then, there’s a property for each key / column, which contains information about how many times it’s appeared, and how many times each appeared for a specific type (number, string, etc.).

.. _create_extraction:

Create Extraction
=================

Once you’ve stored a bunch of data, you’re going to want to get it out so you can do analysis on it! This is easy to do through the Keen UI, but we have easy programmatic access as well. Let’s say we want to extract from the "user_interactions" collection. First, we have to create the JSON payload that contains information to control the extraction request. Create a file called "extraction.json" and save it to your filesystem with the following content:

::

    {
        "clauses": [
        {
            "property": "body:type",
            "operator": "eq",
            "value": "mouse_click"
        }
        ],
        "email": "alert@keen.io"
    }

The important pieces of information are the "clauses" and "email" properties. "clauses" contains a list of JSON objects, each of which is a specific :doc:`filter </api/usage/filters>` criteria. In this example, we’re saying we only want events whose "type" column has a value equal to "mouse_click". See the API reference guide for all supported operators. The "email" property is optional. If specified, Keen will e-mail the given address whenever the extraction has completed.

-------
Request
-------

::

    curl https://api.keen.io/2.0/projects/<PROJECT_ID>/user_interactions/_extracts -H "Authorization: <API_KEY>" -d @extraction.json

--------
Response
--------

::

    {
        "status": "complete",
        "_id": "4f72644f498e4734f4003e89",
        "results_url": "https://s3.amazonaws.com/keen_service/..."
    }

You just created an extraction request in Keen. The system will process your request and then wait for you to ask for the results when you’re ready. Make note of the "_id" property! It’s important!

.. _get_extraction:

Get Extraction Results
======================

Now that you’ve created an extraction, you want to get the results. For this, you’ll need the ID of the extraction request you created (see previous example). Example:

-------
Request
-------

::

    curl https://api.keen.io/2.0/projects/<PROJECT_ID>/user_interactions/_extracts/<EXTRACTION_ID> -H "Authorization: <API_KEY>"

--------
Response
--------

::

    {
        "status": "complete",
        "_id": "4f72644f498e4734f4003e89",
        "results_url": "https://s3.amazonaws.com/keen_service/..."
    }

Your results have been saved to S3. Simply copy and paste the value from "results_url" to a browser and they will download to your computer.

.. _count:

Get Count
=========

Okay, you've stored data and retrieved it, but now it's time to do some analysis in Keen itself. Perhaps the most basic piece of information you can ask for is the number of events matching a set of criteria in a specific collection.

Just as with :ref:`creating an extraction<create_extraction>`, you'll probably want to provide a list of clauses to use as a :doc:`filter </api/usage/filters>`. This is optional, so leave it out if you want! But if you do want to only count events that match certain criteria, then follow along.

Unlike :doc:`Data Collection API </api/usage/data_collection>` calls, :ref:`count metric` is a :doc:`Metric </api/usage/metrics>`, which uses query string parameters. The first is the "filters" parameter. Its value is a URL-encoded JSON string that represents the clauses you want to use to filter the collection. The value should be identical in form to the one used when :ref:`creating an extraction<create_extraction>`. Let's take an example. Let's say our clauses are the following:

::

    [
        {
            "property": "body:type",
            "operator": "eq",
            "value": "mouse_click"
        }
    ]

Note that the root object is a list. Once we convert this to a URL-encoded JSON string, it'll look like:

::

    %5B%7B%22property%22%3A%20%22body%3Atype%22%2C%20%22operator%22%3A%20%22eq%22%2C%20%22value%22%3A%20%22mouse_click%22%7D%5D

I know, pretty ugly, right? But it's important to support this so that our users can easily embed links to our analysis APIs (like Count!) in their websites and dashboards. Which leads us to our second query string parameter: "api_key".

The "api_key" parameter is optional. It allows you to specify your API key through a query string parameter instead of through the "Authorization" header as with our other APIs. This makes embedding links much easier. If you don't use this parameter, we do require that you specify the "Authorization" header.

-------
Request
-------

::

    curl https://api.keen.io/2.0/projects/<PROJECT_ID>/user_interactions/_count?filters=<URL_ENCODED_JSON_STRING>&api_key=<API_KEY>"

--------
Response
--------

::

    {
        "result": 1
    }

