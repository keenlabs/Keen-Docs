======================
JavaScript Usage Guide
======================

============
Introduction
============

The Keen IO JavaScript SDK is designed to be simple to develop with, yet incredibly flexible. Our goal is to let you decide what events are important to you, use your own vocabulary to describe them, and decide when you want to send them to Keen IO.

* :ref:`install-guide` - How to include the Keen IO JavaScript SDK into your application or website.
* :ref:`configure-sdk` - How to configure the Keen IO JavaScript SDK with your Project ID and API Key.
* :ref:`add-events` - How to add an event with the Keen IO JavaScript SDK.

Got questions or feedback? Come hang out with us in the `Keen IO User Chat`_.

------------------------
Get Project ID & API Key
------------------------

If you haven't done so already,  `login to Keen.io to create a project <https://keen.io/add-project>`_  for your app. 

.. _install-guide:

=============
Install Guide
=============

Installing the SDK should be a breeze. If it's not, please let us know at team@keen.io!

Our recommended way of using the Keen IO JavaScript SDK is to include it from its official spot on S3.

https://keen_web_static.s3.amazonaws.com/code/keenio-1.0.0.min.js

Copy and paste the following code into your HTML page to give this a shot (make sure to put this after your body tag):

.. code-block:: html

    <script type="text/javascript" src="https://keen_web_static.s3.amazonaws.com/code/keenio-1.0.0.min.js"></script>

===========
Usage Guide
===========

---------------
Instrumentation
---------------

Now it’s time to actually use the SDK!

.. _configure-sdk:

^^^^^^^^^^^^^
Configure SDK
^^^^^^^^^^^^^

Configure the Keen IO JavaScript SDK with your Project ID and API Key. Do this before using any other code from the Keen IO JavaScript SDK. Here's some example code:

.. code-block:: javascript

    Keen.configure("your_project_id", "your_api_key");
  
Keen.configure() sets up the SDK to be used later. Now you're ready to do the fun stuff!

.. _add-events:

^^^^^^^^^^
Add Events
^^^^^^^^^^

Add events to track. Here’s a very basic example for an app that tracks "purchases".

.. code-block:: javascript

    var trackPurchase = function () {
        // create an event as a JS object
        var purchase = {
            item: "golden widget"
        };

        // add it to the "purchases" collection
        Keen.addEvent("purchases", purchase);
    };

The idea is to create an arbitrary JS Object of JSON-serializable values.
  
.. note:: The JSON spec doesn't include anything about date values. At Keen IO, we know dates are important to track. Keen IO sends dates back and forth through its API in ISO-8601 format. The SDK handles this for you.

The properties of the JS Object must be valid Keen Property Names. A Keen Property Name must follow these rules:

* Cannot start with the $ character.
* Cannot contain the . character anywhere.
* Cannot be longer than 256 characters.

Add as many events as you like. The SDK will fire off each event to the Keen IO servers asynchronously.

The SDK will automatically stamp every event you track with a timestamp. If you want to override the system value with your own, use the following example. Note that the "timestamp" key is set in the *header* properties dictionary.

.. code-block:: javascript

    var trackPurchase = function () {
        // create an event as a JS object
        var purchase = {
            item: "golden widget",
            header: {
                timestamp: new Date()
            }
        };

        // add it to the "purchases" collection
        Keen.addEvent("purchases", purchase);
    };
  
^^^^^^^^^^^^^^^^^
Global Properties
^^^^^^^^^^^^^^^^^

Now you might be thinking, "Okay, that looks pretty easy. But what if I want to send the same properties on EVERY event in a particular collection? Or just EVERY event, period?" We've got you covered through something we call Global Properties. 

Global properties are properties which are sent with EVERY event. For example, you may wish to always capture device information like OS version, handset type, orientation, etc.

To use global properties, simply set the *globalProperties* member of Keen to a function you've defined which takes in event collection as a string parameter and returns a JS object of all the global properties for that collection.

Here's an eaxmple:

.. code-block:: javascript

    var myGlobalProperties = function(eventCollection) {
        // setup the global properties we'll use
        var globalProperties = {
            someStandardProperty: 42
        };
        // do something extra for a specific event collection
        if (eventCollection === "purchase") {
            globalProperties["isPurchase"] = true;
        }
        return globalProperties;
    };
    Keen.globalProperties = myGlobalProperties;

.. note:: If there are two properties with the same name specified in the user-defined event AND the global properties, the user-defined event's property will be the one used.

.. _Keen IO User Chat: https://users.keen.io
