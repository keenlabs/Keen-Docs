===================
Data Modeling Guide
===================
Keen provides public REST APIs to perform both :doc:`Data Collection </data-collection/index>` and :doc:`Data Analysis </data-analysis/index>`. We also offer full export so you can pump data into your existing analysis workflow and flex your muscles in Excel, Tableau, or Hadoop.

We believe in the power of data to uncover new truths about what's important in your application. However, in order to truly leverage your data and our analysis suite, you'll need to put some thought into the types of things you want to record and how you will record them. We created this data modeling guide to help you get the most out of your data.

We’d love to get your advice on what could make our product and this documentation simpler or more powerful. Please, please, please share your feedback with team@keen.io. We'd love to hear from you.


.. _projects:

Projects
========

The first step in integrating your application with Keen is the creation of a Project. You can think of a project as a data silo. The data in a Project is completely separate from data in other projects.

There are a few scenarios where it makes sense to create multiple projects to logically separate data:

* If you have more than one application, create a separate project for each app. For example you might have a project called Eat My Shorts App and another one called CraftMine App.
* You probably have a production environment and a test environment. It’s a good idea to separate that data to avoid accidentally polluting your production data store with test data. Continuing our example, you would have 4 projects:

    * Eat My Shorts App - Staging
    * Eat My Shorts App - Prod
    * CraftMine - Staging
    * CraftMine - Prod

* If you run your app on multiple platforms --- iOS and Android for example --- we recommend storing that data in a shared project rather than creating separate projects. Having your iOS and Android events in a single project will make it much easier to do analysis across platforms. You’ll be able to ask questions like "how many people are using our app? How many people are using our new feature?". You can always use :doc:`filters </data-analysis/filters>` to do comparisons between the platforms --- just make sure you include a platform property when sending data.
* If you have an application with many similar instances, for example an app for restaurants with a different version for each restaurant, `email us`_ and we will help you figure out the best way to structure your projects. There may be cases where you want to logically separate data for different companies while at the same time requiring cross-project analysis -- we can help!

.. _email us: team@keen.io


.. _event-data:

Events & Event Data
===================
Our database is optimized to store *event data*. Events are actions that occur at a point in time. These actions can be performed by a user, an admin, a server, a program, etc. Events have *properties*.  Properties are the juicy bits of data that describe what is happening and allow you to do in-depth analysis. When we talk about "event data" we mean events and all the properties that you send along with them. 

Here is an example of a Purchase event and its properties. There's a timestamp property that's automatically included at the top, plus a set of custom properties like item, cost, customer, and store.


.. code-block:: none

    {
        "keen": {
            "timestamp": "2012-06-06T19:10:39.205000"
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
    }


This event is sent to Keen using an HTTP POST request to a URL of the following format:

.. code-block:: none

   http://api.keen.io/3.0/projects/<project_id>/events/<event_collection>

Read on for more info on Event Properties and Event Collections.

.. _event-properties:

Event Properties
================

Properties are pieces of information that describe an event and relevant information about things related to that event.

When we talk about events and their properties, we are starting to dig into the art of data science. There is no prescription for what events you should record and what properties will be important for your unique application. Rather, you need to think creatively about what information is important to you now and what might be important in the future. We believe that it can’t hurt to have too much information. Here are some things to consider capturing as event properties:

* Information about the event itself. If your event is a phone call, what number is being called? How many times did the phone ring? Did someone answer?
* Information about the actor performing the event. For example, if you’re recording a user action, what do you know about the user at that point in time? If possible, record their age, gender, location, favorite coffee shop, or whatever else you know that might be useful for analyzing their behavior later.
* Information about other actors involved. For example, if your event is a user sharing content with another user, you could record the properties of the recipient. What is their name? To what groups do they belong?
* Information about the session - How long has your app been running since this event occurred? Is this the user’s first session?
* Information about the environment. What platform? What hardware? What version of your application?
* Other relevant information about the "state of the universe" - If you think that sounds vague, I agree with you! Think about anything else that might be handy to know later. If you’re making a farming game, record the items in a user’s garden and their coordinates. You might find some interesting usage patterns.  Maybe people who spend over $30 all have statues in their garden --- maybe you could add more fancy decorations to the game to entice them to spend more?

Though it might seem counter-intuitive and redundant to send the same information (e.g. user info, platform info) with every event, it will make it much easier for you to segment your data later.

Feel free to add or remove events and properties from your code at any time. Keen will automatically keep track of whatever you send, and your new properties will be available for analysis immediately.

.. _property-types:

Property Types
+++++++++++++++++++++++++++++++++

We wanted to let our advanced users know that there are actually two different property types in Keen. A majority of folks don't need to know these property distinctions, but if you have advanced timestamp needs, you might find this useful.

These are the two property types:

* **Your properties** describe the event and are provided by you, the API user.
* **Keen properties** are properties automatically provided by Keen. They can be overwritten by the API user.

Here's an example event POST payload:

.. code-block:: none

    {
        "keen": {
            "timestamp": "2012-06-06T19:10:39.205000"
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
    }


The keen.timestamp property is used by Keen's clients to capture the time when an event occurs. This can be overwritten if you provide you own value for this key. For example, when recording an event, you can provide your own keen.timestamp to specify that an event happened in the past.

If you're interacting with the REST API directly (not using a client), you should send a timestamp using the keen.timestamp property, in the format shown in the example. If you don't provide a keen.timestamp, Keen will add one at the time the event is received. 

keen.timestamp is used for all of that analysis queries that use a :doc:`timeframe </data-analysis/timeframe>`. That's why we recommend that you use this property to store your timestamps. 

Currently, the only special supported by the Keen is the **keen.timestamp** property. 



.. _property hierarchy:

Property Hierarchy
+++++++++++++++++++++++++++++++++

The nice thing about using `JSON`_ as the data format is that you can include LOTS of properties with your events, and you can organize them in a hierarchy.

You can see in the example below that this purchases event has properties that describe the purchase, properties that describe the customer, and properties that describe the store.

The ability to store the properties in this hierarchy makes it much simpler to name the properties. Notice how the customer name and the store name are simply labeled "name". When you look for these properties in a filter or in your data extract, you’ll find them labeled **customer.name** and **store.name**.

.. code-block:: none

    {
       "item": "sophisticated orange turtleneck with deer on it",
       "cost": 469.50,
       "payment_method": "Bank Simple VISA",
       "customer": {
           "id": 233255,
           "name": "Francis Woodbury",
           "age": 28,
           "address": {
               "city": "San Francisco",
               "country": "USA"
           }
       },
       "store": {
           "name": "Yupster Things",
           "city": "San Francisco",
           "address": "467 West Portal Ave"
       }
    }

This is a simple example --- your hierarchy can have as many levels and properties as you want!

.. _property data types:

Property Data Types
+++++++++++++++++++++++++++++++++

Properties have data types.  Keen automatically infers the data types of your properties based on the data that you send. The possible data types are:

* **string** -  string of characters
* **number** -  number or decimal
* **boolean** - either *true* or *false*
* **array** - collection of data points of like data types

When you’re performing analysis on your data, you might notice that you have different filtering options for different properties. That’s because Keen automatically detects the relevant operators based on your property’s data type. For example, you won’t have the option to apply a greater than or less than filter to boolean property with only TRUE or FALSE property values (that would be super confusing!).  For a list of the possibilities, check out :doc:`filters </data-analysis/filters>`.


.. _JSON: http://json.org

.. _event-collections:

Event Collections
=================

Event Collections are used to logically organize all the events happening in your application. Events belong in a collection together when they can be described by similar properties. For example, all Logins share properties like first name, last name, app version, platform, and time since last login. It makes sense to store all of your logins in an Event Collection called Logins.

Logins are just one example of an Event Collection. Here are some more: purchases, social media shares, comments, saves, exits, upgrades, errors, levelups, interactive gestures, modifications, views, signups.


How to Create an Event Collection
+++++++++++++++++++++++++++++++++
Event Collections are created automatically when you send an event to Keen. The event collection name is required in order to send an event. If the event collection name doesn’t exist yet, Keen will automatically create it when your first event is received.

As soon as an Event Collection’s first event is recorded, the collection will be immediately available for analysis via the Keen website and our API. All of the event properties (and any ones you add with subsequent events) will automatically appear in the web interface when adding :doc:`filters </data-analysis/filters>` to your new Event Collection.

Best Practices for Event Collections
++++++++++++++++++++++++++++++++++++
Some things to consider when creating your event collections:

#. Events in an Event Collection have similar properties. For example, all Logins share properties like first name, last name, app version, platform, and time since last login.
#. Events Collections for a given application share many "global properties". For example, most events in your application probably share some properties like user ID, app version, and platform. It’s a good planning exercise to identify those properties that you want to include in every Event Collection so you can structure them the same way each time.
#. When possible, minimize the number of distinct Event Collections. Let’s say you’re analyzing purchases across many devices and you want to compare them. You've got purchases from multiple versions of your iPhone app and multiple versions of your iPad app.  It’s logical to think of creating separate event collections for each of them, but it’s not the best way. Instead, consider creating a single event collection called Purchases. Each purchase in your event collection share many properties like item description, unit price, quantity, payment method, and customer. Additionally, you can include the property DeviceType (iPhone, iPad, etc) and Version (2.4A, 2.4B, 1.3).

Since you’re now tracking those Device & Version properties for every purchase, it’s very easy to do the following:

* count the total number of purchases across all devices
* count the total number of purchases where DeviceType equals "iPhone"
* count the total number of purchases for iPhone app version 2.4A.

Check out the :doc:`filters </data-analysis/filters>` page for more information on how to slice and dice your data.
