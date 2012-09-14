Getting Started Guide
=====================

==================
What Are We Doing?
==================
This we believe: Getting started with Keen APIs should be easy. For the technical wizards among you, this guide will take you 8 minutes and you can dig into the advanced documentation. For the sorcerer's apprentices, this shouldn't take much more than 17 minutes. If it does, we've failed. `Let us know <team@keen.io>`_. 

If you’re looking for the Keen Service API Technical Reference, go :doc:`here<api/reference>`. It’s great if you already know the basic elements of the Keen API and want to see a list of every endpoint and example requests and responses along with technical details.

Once you're through this guide, we hope you'll be square on the following: 

* How we think about and organize analytics data. 
* How to setup a project. 
* How to submit sample data and do a little something with it. 

You don't need a preexisting application to walk through this guide, and we've tried to limit the technical background required of you as well. This is just about Keen. Once we get through that, we'll hand you off to the :doc:`data_collection/data_collection` and :doc:`data_analysis/data_analysis` documentation.

===========
Assumptions
===========

* You've been granted developer preview access. Keen is still in private beta, so access is limited to the choicest of rockstars. You can request access `here <http://keen.io>`_. 
* You've got some familiarity with the command line shell. You won't be hacking into the Matrix, so don't worry if this isn't a strength. We also reference `cURL <http://en.wikipedia.org/wiki/CURL>`_, but you don't really need an understanding to get the job done in this guide.
* You're a bit impatient and will `let us know <team@keen.io>`_ if our service could be better. 
* You've got a high level understanding of `APIs <http://en.wikipedia.org/wiki/API>`_ and `JSON <http://en.wikipedia.org/wiki/JSON>`_. 

We're not asking much, right? 

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

------------------
Create a Project
------------------
If you've not already done so, you need to `create a project <https://keen.io/add-project>`_. Since we're just practicing, you might want to give it a sufficiently silly name like "Getting Keeny" or "Windows ME". Make note of the Project ID and the API Key. You'll need those soon.  

-------------
Send an Event
-------------

Let's get to the heart of it - sending events. You need to know your Project ID, API Key,  and you'll need to name the event that you want to record. For this example, we’ll call our event collection "purchase", but you can pick almost any name!

So we’ll insert a new "purchase" event into our project. The event looks like this:

::


    {
        "body": {
			"category": "magical animals",
			"animal_type": "pegasus",
			"username": "perseus",
			"payment_type": "head of medusa"
		}
    }

Save that JSON to a file on your filesystem. We’re naming ours "purchase1.json". You can send your event to Keen by entering the following on the command line (with your Project ID and API Key rather than the placeholders): 

::

    curl https://api.keen.io/2.0/projects/<PROJECT_ID>/purchase -H "Authorization: <API_KEY>" -H "Content-Type: application/json" -d @purchase1.json

Breaking the request across a couple of lines makes it look like this. A bit easier to read, no?

::

    curl https://api.keen.io/2.0/projects/<PROJECT_ID>/purchase
      -H "Authorization: <API_KEY>"
      -H "Content-Type: application/json"
      -d @purchase1.json

There are a couple things going on here. 

* First, we send the request to a URL that includes both the Project ID and the name of the event collection we want to insert into. 
* Second, we set headers for both authorization (with your API Key) and content-type (so the API knows it’s getting a JSON request). 
* Third, we tell cURL to set the body of the HTTP request to the contents of the file that we saved.

The response should look like:  

::

    {
        "created": true
    }
	
Winning!	
	
------------
Count Events
------------

Through our data analysis API, you'll have access to a number of different tools. But, for the moment, let's just worry about one - counts. It exactly what it sounds like it does - counts the number of times an event has occurred. 

The first query string parameter is the "api_key". You know where to find this from earlier. However, you might have noticed that we're using a different type of authentication (parameter vs. header). We wanted to give you a couple of options.

-------
Request
-------

::

   curl https://api.keen.io/2.0/projects/<PROJECT_ID>/purchase/_count?api_key=<API_KEY>

--------
Response
--------

::

    {
        "result": 1
    }

Yup. 1. We only inserted one event, so that's all we can count. This is just a getting started guide. 

=======================
Get to Work, For Realz
=======================

Congratulations! You've graduated from the Keen Getting Started guide. Admittedly, we've just scratched the surface, but hopefully you've got some context on which you can build. 

Now, go do something useful. 

--------------------
Data Collection APIs
--------------------
We built a massively scalable event data warehouse so that you can send us whatever data you want without having to worry about storage or performance. You can dive into all of our data collection API docs :doc:`here <data_collection/data_collection>`.

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

Our suite of analysis offerings is available :doc:`here </data_analysis/data_analysis>`.