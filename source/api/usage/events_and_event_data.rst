===================
Events & Event Data
===================

Our database is optimized to store event data. Events are actions that occur at a point in time. These actions can be performed by a user, an admin, a server, a program, etc. Events have properties.  Properties are the juicy bits of data that describe what is happening and allow you to do in-depth analysis. When we talk about “event data” we mean events and all the properties that you send along with them. Here are some examples of a Purchase event and its properties.

To send an event to Keen, simply send an HTTP POST request to a URL of the following format:

.. code-block:: none

    http://api.keen.io/2.0/projects/<project_id>/<event_name>

The body of the POST request contains the :doc:`event properties<event_properties>` and looks similar to this.  Note the two property types -- header and body.

.. code-block:: none

    {
        "header": {
            "timestamp": "2012-06-06T19:10:39.205000"
        },
        "body": {
            "item": "sophisticated orange turtleneck with deer on it",
            "cost": 469.5,
            "payment_method": “Bank Simple VISA”,
            "customer": {
                "name": “Francis Woodbury”,
                "age": 28,
            },
            "store": {
                "name": “Yupster Things”,
                "city": “San Francisco”,
                "address": “467 West Portal Ave”,
            }
        }
    }

To find out more about sending events to Keen, check out our Data Collection API.

.. _event collections:

Event Collections
=================

Event Collections are used to logically organize all the events happening in your application. Events belong in a collection together when they can be described by similar properties. For example, all Logins share properties like first name, last name, app version, platform, and time since last login. It makes sense to store all of your logins in an Event Collection called Logins.

Logins are just one example of an Event Collection. Here are some more: purchases, social media shares, comments, saves, exits, upgrades, errors, levelups, interactive gestures, modifications, views, signups.


How to Create an Event Collection
+++++++++++++++++++++++++++++++++
Event Collections are created automatically when you send an event to Keen. The event collection name is required in order to send an event. If the event collection name doesn’t exist yet, Keen will automatically create it when your first event is received.

As soon as an Event Collection’s first event is recorded, the collection will be immediately available for analysis via the Keen website and our API. All of the event properties (and any ones you add with subsequent events) will automatically appear in the web interface when adding filters to your new Event Collection.

Best Practices for Event Collections
++++++++++++++++++++++++++++++++++++
Some things to consider when creating your collections:

#. Events in an Event Collection have similar properties. For example, all Logins share properties like first name, last name, app version, platform, and time since last login.
#. Events Collections for a given application share many “global properties”. For example, most events in your application probably share some properties like user ID, app version, and platform. It’s a good planning exercise to identify those properties that you want to include in every Event Collection so you can structure them the same way each time.
#. When possible, minimize the number of distinct Event Collections. Let’s say you’re analyzing purchases across many devices and you want to compare them. You've got purchases from multiple versions of your iPhone app and multiple versions of your iPad app.  It’s logical to think of creating separate collections for each of them, but it’s not the best way. Instead, consider creating a single collection called Purchases. Each purchase in your collection share many properties like item description, unit price, quantity, payment method, and customer. Additionally, you can include the property DeviceType (iPhone, iPad, etc) and Version (2.4A, 2.4B, 1.3).

  Since you’re now tracking those Device & Version properties for every purchase, it’s very easy to do the following:

  * count the total number of purchases across all devices
  * count the total number of purchases where DeviceType equals “iPhone”
  * count the total number of purchases for iPhone app version 2.4A.

Check out the Filters page for more information on how to slice and dice your data.
