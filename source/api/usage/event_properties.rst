================
Event Properties
================

Properties are pieces of information that describe an event and relevant information about things related to that event.

When we talk about events and their properties, we are starting to dig into the art of data science. There is no prescription for what events you should record and what properties will be important for your unique application. Rather, you need to think creatively about what information is important to you now and what might be important in the future. We believe that it can’t hurt to have too much information. Here are some things to consider capturing as event properties:

* Information about the event itself. If your event is a phone call, what number is being called? how many times did the phone ring? Did someone answer?
* Information about the actor performing the event. For example, if you’re recording a user action, what do you know about the user at that point in time? If possible, record their age, gender, location, favorite coffee shop, or whatever else you know that might be useful for analyzing their behavior later.
* Information about other actors involved. For example, if your event is a user sharing content with another user, you could record the properties of the recipient. What is their name? To what groups do they belong?
* Information about the session - How long has your app been running since this event occurred? Is this the user’s first session?
* Information about the environment. What platform? What hardware? What version of your application?
* Other relevant information about the “state of the universe” - If you think that sounds vague, I agree with you! Think about anything else that might be handy to know later. If you’re making a farming game, record the items in a user’s garden and their coordinates. You might find some interesting usage patterns.  Maybe people who spend over $30 all have statues in their garden --- maybe you could add more fancy decorations to the game to entice them to spend more?

Though it might seem counter-intuitive and redundant to send the same information (e.g. user info, platform info) with every event, it will make it much easier for you to segment your data later.

Feel free to add or remove events and properties from your code at any time. Keen will automatically keep track of whatever you send, and your new properties will be available for filtering immediately.

.. _property types:

Property Types
==============

Although you will spend most of your time working with your unique event properties, we wanted to let our advanced users know that there are actually two property types. This is particularly relevant for anyone with custom timestamp needs.

The two property types are:

* **Header properties** are standard properties supported by Keen.
* **Body properties** describe the event and are provided by you, the API user

Currently, the only header property supported by the Keen is the **header:timestamp** property. We reserved the header object so we can support more standard properties in the future.

You might have noticed the “header” and “body” distinction in our example event POST payload:

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

Just in case you have a complex or atypical use case, our data collection API gives you the ability to modify and overwrite the header properties provided by Keen.  For example, when recording an event, you can provide your own timestamp to specify that an event happened in the past.

.. _property hierarchy:

Property Hierarchy
====================

The nice thing about using a `JSON`_ data format is that you can include LOTS of properties with your events, and you can organize them in a hierarchy.

You can see in the example below that this purchases event has properties that describe the purchase, properties that describe the customer, and properties that describe the store.

The ability to store the properties in this hierarchy makes it much simpler to name the properties. Notice how the customer name and the store name are simply labeled “name”. When you look for these properties in a filter or in your data extract, you’ll find them labeled **customer:name** and **store:name**.

.. code-block:: none

    {
        "body": {
            "item": "sophisticated orange turtleneck with deer on it",
            "cost": 469.50,
            "payment_method": “Bank Simple VISA”
            "customer": {
                "id": 233255
                "name": “Francis Woodbury”,
                "age": 28,
                "address": {
                    "city": “San Francisco”,
                    "country": “USA”
                }
            },
            "store": {
                "name": “Yupster Things”,
                "city": “San Francisco”,
                "address": “467 West Portal Ave”
            }
        }
    }

This is a simple example --- your hierarchy can have as many levels and properties as you want!

.. _property data types:

Property Data Types
===================

Properties have data types.  Keen automatically infers the data types of your properties based on the data that you send. The possible data types are:

* **string** -  string of characters
* **number** -  number or decimal
* **boolean** - either *true* or *false*
* **array** - collection of data points of like data types

When you’re performing analysis on your data, you might notice that you have different filtering options for different properties. That’s because Keen automatically detects the relevant operators based on your property’s data type. For example, you won’t have the option to apply a greater than or less than filter to boolean property with only TRUE or FALSE property values (that would be super confusing!).  For a list of the possibilities, check out our section under filtering.


.. _JSON: http://json.org