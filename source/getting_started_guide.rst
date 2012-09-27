Getting Started Guide
=====================

==================
What Are We Doing?
==================
This we believe: Getting started with Keen APIs should be easy. For the technical wizards among you, this guide will take you 8 minutes and you can dig into the advanced documentation. For the sorcerer's apprentices, this shouldn't take much more than 17 minutes. If it does, we've failed. `Let us know <team@keen.io?Subject=Getting Started Feedback>`_. 

Once you're through this guide, we hope you'll be square on the following: 

* How we think about and organize analytics data. 
* How to setup a project and create an event collection.
* How to submit sample data and do a little something with it. 

You don't need a preexisting application to walk through this guide, and we've tried to limit the technical background required of you as well. This is just about Keen. Once we get through that, we'll hand you off to the :doc:`data_collection/data_collection` and :doc:`data_analysis/data_analysis` documentation.

This guide assumes that you've been granted developer preview access. Keen is still in private beta, so access is limited to the choicest of rockstars. If you don't have a Keen login yet, you can request access `here <http://keen.io>`_. 


=========================
How We Think About Things
=========================

Before we jump into the tech, it's important to know how we think about things. We put together a pretty comprehensive document on :doc:`data modeling </event_data_modeling/event_data_intro>` that you should certainly review in a bit. For this exercise, here's what you need to know:

* **Projects** - A project amounts to a data silo. The information in one project isn't available to other projects. Practically speaking, in the mobile world, a project is an app. 
* **Events** - These are the actions that are happening in your app that you want to track. You can record whatever you want.  
* **Event Collections** - Event Collections logically organize all the events happening in your application. So, for example, when you collect multiple "login" events, they will all be stored in the login event collection.
* **Properties** - Properties describe and give context to events. They answer the who (username), when (timestamp), where (geolocation) questions you might have.  

==============
Project Setup
==============

If you've not already done so, you need to `create a project <https://keen.io/projects>`_. Since we're just practicing, you might want to give it a sufficiently silly name like "Getting Keeny" or "Windows ME". Make note of the Project ID and the API Key. You'll need those soon.  

=============
Send an Event 
=============


Let's get to the heart of it - sending events. You need to know your Project ID, API Key, and a name for your new Event Collection. For this example, we’ll call our new Event Collection "purchases", but you can pick almost any name!

So we’ll insert a new "purchase" event into our project. The event looks like this

.. code-block:: javascript

  {
    "body": {
      "category": "magical animals",
      "animal_type": "pegasus",
      "username": "perseus",
      "payment_type": "head of medusa"
    }
  }

The format of this event is called `JSON <http://en.wikipedia.org/wiki/JSON>`_. All events are sent to Keen in this format. 

Now create your own event. You can start by copying our example above, pasting it into a text file, and saving it as a ".json" file. We’re naming ours "purchase1.json". 

Next we'll send this event to Keen using a command line interface like Mac's Terminal. `cURL <http://en.wikipedia.org/wiki/CURL>`_ is a simple data transfer program built into most operating systems. 

Send your event to Keen by copying, modifying, then pasting the following cURL command into your terminal (use your Project ID and API Key rather than the <placeholders>). 

Note: Make sure to navigate your Terminal prompt to the place where you saved your event, or add a file path to your file name. 

::

    $ curl https://api.keen.io/3.0/projects/<PROJECT_ID>/events/purchases -H "Authorization: <API_KEY>" -H "Content-Type: application/json" -d @purchase1.json

Breaking the request across a couple of lines makes it look like this. A bit easier to read, no?

::

    curl https://api.keen.io/3.0/projects/<PROJECT_ID>/events/purchases
      -H "Authorization: <API_KEY>"
      -H "Content-Type: application/json"
      -d @purchase1.json

There are a couple things going on here. 

* First, we send the request to a URL that includes both the Project ID and the name of the :ref:`Event Collection <event-collections>` (purchases) where we want to store this event.
* Since the collection "purchases" doesn't exist yet, Keen creates a new event collection for you called "purchases" and stores your event there. Now you have a place to send all your purchase events in the future. 
* Second, we set headers for both authorization (with your API Key) and content-type (so the API knows it’s getting a JSON request). 
* Third, we set the body of the HTTP request to the contents of the file that we saved.

The response should look like::

    {
        "created": true
    }
	
Winning!	
	
============
Count Events
============

Through our data analysis API, you'll have access to a number of different tools. But, for the moment, let's just worry about one - counts. It exactly what it sounds like it does - counts the number of times an event has occurred. 

We'll try a very simple version of a count here. The first query string parameter is the "api_key". You know where to find this from earlier. The second parameter is the name of the Event Collection "event_name" where we want to do analysis. 

Replace the <PROJECT_ID> and <API_KEY> with your own, then enter this request in your browser bar. 
Note: If you used an Event Collection Name other than "purchases", don't forget to change that part too.

-------
Request
-------

::

	https://api.keen.io/3.0/projects/<PROJECT_ID>/probes/count?api_key=<API_KEY>&event_name=purchases

--------
Response
--------

::

    {
        "result": 1
    }

Yup. 1. We only inserted one event, so that's all we can count. This is just a getting started guide. Here a couple more simple examples just to show off:

Add a :doc:`data_analysis/timeframe` parameter to limit the results to events that happened in the past 3 hours:

-------
Request
-------

::
	
	https://api.keen.io/3.0/projects/<PROJECT_ID>/probes/count?api_key=<API_KEY>&event_name=purchases&timeframe=last_3_hours
	
--------
Response
--------

::
	
	    {
	        "result": 1
	    }
	
Now add an :doc:`data_analysis/interval` parameter to that query to get separate results for each of the last 3 hours:

-------
Request
-------

::

	https://api.keen.io/3.0/projects/<PROJECT_ID>/probes/count?api_key=<API_KEY>&event_name=purchases&timeframe=last_3_hours&interval=hourly

--------
Response
--------

::

	{
	  "result": [
	    {
	      "timeframe": {
	        "end": "2012-09-26T15:00:00+00:00", 
	        "start": "2012-09-26T14:00:00+00:00"
	      }, 
	      "value": 0
	    }, 
	    {
	      "timeframe": {
	        "end": "2012-09-26T16:00:00+00:00", 
	        "start": "2012-09-26T15:00:00+00:00"
	      }, 
	      "value": 0
	    }, 
	    {
	      "timeframe": {
	        "end": "2012-09-26T17:00:00+00:00", 
	        "start": "2012-09-26T16:00:00+00:00"
	      }, 
	      "value": 1
	    }
	  ]
	}

That's just the beginning. You'll find a lot more analysis tools on `our website <http://keen.io>`_ and our :doc:`API docs<data_analysis/data_analysis>`.

.. image:: keen_tools.*


=======================
Get to Work, For Realz
=======================

Congratulations! You've graduated from the Keen Getting Started guide. Admittedly, we've just scratched the surface, but hopefully you've got some context on which you can build. 

Now, go do something useful. 

Actually, before you do that, could you please let us know what you thought of this guide? What would make it better or less confusing? Drop a note to `team@keen.io <team@keen.io?Subject=Getting Started Feedback>`_.

On to the good stuff...

--------------------
Data Collection APIs
--------------------
We built a massively scalable event data warehouse so that you can send us whatever data you want without having to worry about storage or performance. Dive into :doc:`our data collection API docs <data_collection/data_collection>`.

Or, jump straight to our currently available client usage guides. 

.. toctree::
    :maxdepth: 1
    
    ../clients/iOS/usage_guide
    ../clients/ruby/usage_guide

More are on the way!

------------------
Data Analysis APIs
------------------
We are passionate about building a powerful analysis API so you can get the most out of your data. Our services could be the building blocks for your new custom dashboard or a real-time workflow. I’m sure you’ll think of even more uses we haven’t considered yet :)

Now that you've sent at least one sample event, you can login to Keen.io and check out our query builders. You'll notice that all of the custom properties you send are immediately available for probing. If you're more interested in the API itself, check out our :doc:`documentation on our suite of analysis API offerings</data_analysis/data_analysis>`.
