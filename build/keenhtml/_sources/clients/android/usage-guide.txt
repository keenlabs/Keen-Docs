==========================
Android Client Usage Guide
==========================

============
Introduction
============

The Keen Android client is designed to be simple to develop with, yet incredibly flexible. Our goal is to let you decide what events are important to you, use your own vocabulary to describe them, and decide when you want to send them to the Keen service.

For a detailed class reference, please visit our `Keen Android Client API Reference`_.

* :ref:`install-guide` - How to install the Keen Android Client into your application.
* :ref:`register-client` - How to register your Project ID and API key with the Keen Android Client.
* :ref:`add-events` - How to add an event with the Keen Android Client.
* :ref:`upload-events` - How to upload all previously saved events with the Keen Android Client.

Got questions or feedback? Come hang out with us in the `Keen IO User Chat`_.

------------------------
Get Project ID & API Key
------------------------

If you haven't done so already,  `login to Keen.io to create a project <https://keen.io/add-project>`_  for your app. 

.. _install-guide:

=============
Install Guide
=============

Installing the client should be a breeze. If it's not, please let us know at team@keen.io!

-----------
Add the JAR
-----------

Our recommended way of installing the Keen Client is to use the JAR file we've created. With this, you'll be able to simply drop a JAR into your Android project and go.

.. note:: While we think the JAR file makes things really easy, we love to be transparent. Come check out our work on GitHub at https://github.com/keenlabs/KeenClient-Android. We love feedback, especially in the form of pull requests. :)

^^^^^^^^
Download
^^^^^^^^

Download the JAR file. Get the latest from here:

http://keen.io/static/code/KeenClient-Android.jar

^^^^^^^^^^^^^^^^^^^^^^^
Add JAR to Your Project
^^^^^^^^^^^^^^^^^^^^^^^

1. Create a directory called "libs" in your project.
2. Put the JAR you downloaded previously in the "libs" directory.
3. If you're using an IDE like Eclipse, make sure you refresh your project.

.. note:: If you're using IntelliJ, you'll have to add the JAR as an external library in your settings. If you're not sure how to do that, come ask how in the `Keen IO User Chat`_.

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Enable Required Android Permissions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If it's not already present, add the INTERNET permission to your AndroidManifest.xml file. The entry below should appear between the <manifest> .. </manifest> tags.

.. code-block:: xml

  <uses-permission android:name="android.permission.INTERNET"/>

Usage Guide
===========

---------------
Instrumentation
---------------

Now it’s time to actually use the client!

.. _register-client:

^^^^^^^^^^^^^^^
Register Client
^^^^^^^^^^^^^^^

Register the KeenClient shared client with your project ID and API Key. The recommended place to do this is in the onCreate() method of your main activity. Here’s some example code:

.. code-block:: java

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        // initialize the Keen Client with your Project ID and API Key.
        KeenClient.initialize(getApplicationContext(), KEEN_PROJECT_ID, KEEN_API_KEY);
    }
  
The KeenClient.initialize() does the registration. From now on, in your code, you can just reference the shared client by calling KeenClient.client().

.. _add-events:

^^^^^^^^^^
Add Events
^^^^^^^^^^

Add events to track. Here’s a very basic example for an app that tracks "purchases" whenever the app is resumed.

.. code-block:: java

    @Override
    protected void onResume() {
        super.onResume();

        // create an event to eventually upload to Keen
        Map<String, Object> event = new HashMap<String, Object>();
        event.put("item", "golden widget");

        // add it to the "purchases" collection in your Keen Project
        try {
            KeenClient.client().addEvent(event, "purchases");
        } catch (KeenException e) {
            // handle the exception in a way that makes sense to you
            e.printStackTrace();
        }
    }

The idea is to create an arbitrary Map of JSON-serializable values.
  
.. note:: The JSON spec doesn't include anything about date values. At Keen, we know dates are important to track. Keen sends dates back and forth through its API in ISO-8601 format. The Keen Client handles this for you.

The keys of the Map must be valid Keen Property Names. A Keen Property Name must follow these rules:

* Cannot start with the $ character.
* Cannot contain the . character anywhere.
* Cannot be longer than 256 characters.

Add as many events as you like. The Keen client will cache them on disk until you’re ready to send them.

The client will automatically stamp every event you track with a timestamp. If you want to override the system value with your own, use the following example. Note that the "timestamp" key is set in the header properties dictionary.

.. code-block:: java

    @Override
    protected void onResume() {
        super.onResume();

        // create an event to eventually upload to Keen
        Map<String, Object> event = new HashMap<String, Object>();
        event.put("item", "golden widget");

        // override the Keen timestamp
        Map<String, Object> keenProperties = new HashMap<String, Object>();
        keenProperties.put("timestamp", Calendar.getInstance());

        // add it to the "purchases" collection in your Keen Project
        try {
            KeenClient.client().addEvent(event, keenProperties, "purchases");
        } catch (KeenException e) {
            // handle the exception in a way that makes sense to you
            e.printStackTrace();
        }
    }
  
^^^^^^^^^^^^^^^^^
Global Properties
^^^^^^^^^^^^^^^^^

Now you might be thinking, "Okay, that looks pretty easy. But what if I want to send the same properties on EVERY event in a particular collection? Or just EVERY event, period?" We've got you covered through something we call Global Properties. 

Global properties are properties which are sent with EVERY event. For example, you may wish to always capture device information like OS version, handset type, orientation, etc.

There are two ways to handle Global Properties - one is more simple but more limited, while the other is a bit more complex but much more powerful. For each of them, after you register your client, you'll need to set an Objective-C property on the KeenClient instance you're using. 

**Map-based Global Properties**

For this, the Java getter/setter is for *globalProperties*. The property's value will be a *Map* that you define. Each time an event is added, the Android client will look at the value of this property and add all its contents to the user-defined event. Use this if you have a bunch of static properties that you want to add to every event.

Here's an example using a map:

.. code-block:: java

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        // initialize the Keen Client with your Project ID and API Key.
        KeenClient.initialize(getApplicationContext(), KEEN_PROJECT_ID, KEEN_API_KEY);

        // register globalProperties (OPTIONAL)
        Map<String, Object> globalProperties = new HashMap<String, Object>();
        globalProperties.put("some standard property", "some standard value");
        KeenClient.client().setGlobalProperties(globalProperties);
    }

.. note:: If there are two properties with the same name specified in the user-defined event AND the global properties, the user-defined event's property will be the one used.

**Evaluator-based Global Properties**

For this, the Java getter/setter is for *globalPropertiesEvaluator*. The property's value will be an instance of *GlobalPropertiesEvaluator*, a custom interface defined by the Keen Client. Every time an event is added, the evaluator will be called. The client expects the evaluator to return a Map consisting of the global properties for that event collection. Use this if you have a bunch of dynamic properties (see below) that you want to add to every event.

Here's an example using evaluators:

.. code-block:: java

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        // initialize the Keen Client with your Project ID and API Key.
        KeenClient.initialize(getApplicationContext(), KEEN_PROJECT_ID, KEEN_API_KEY);

        // register a GlobalPropertiesEvaluator (OPTIONAL)
        KeenClient.client().setGlobalPropertiesEvaluator(new GlobalPropertiesEvaluator() {
            public Map<String, Object> getGlobalProperties(String s) {
                // create a map to hold all the details we'll save about android
                Map<String, Object> androidDetails = new HashMap<String, Object>();
                androidDetails.put("API Version", Build.VERSION.SDK_INT);
                androidDetails.put("Device Orientation", getResources().getConfiguration().toString());

                // create a map to hold the above map and any other global properties you may want to store
                Map<String, Object> globalProperties = new HashMap<String, Object>();
                globalProperties.put("Android", androidDetails);

                // return those global properties
                return globalProperties;
            }
        });
    }
  
The evaluator takes in a single string parameter which corresponds to the name of this particular event. And we expect it to return a Map of your construction. This example doesn't make use of the parameter, but yours could!

.. note:: Because we support an instace of an interface here, you can create DYNAMIC global properties. For example, you might want to capture the orientation of the device, which obviously could change at run-time. With the evaluator, you can use functional programming to ask the OS what the current orientation is, each time you add an event. Pretty useful, right?

.. note:: Another note - you can use BOTH the map AND the evaluator at the same time. If there are conflicts between defined properties, the order of precedence is: user-defined event > evaluator-defined event > map-defined event. Meaning the properties you put in a single event will ALWAYS show up, even if you define the same property in one of your globals.

.. _upload-events:

^^^^^^^^^^^^^^
Upload to Keen
^^^^^^^^^^^^^^

Upload the captured events to the Keen service. This must be done explicitly. We recommend doing the upload when your application is sent to the background, but you can do it whenever you’d like (for example, if your application typically has very long user sessions). The uploader spawns its own background thread so the main UI thread is not blocked.

.. code-block:: java

    @Override
    protected void onPause() {
        // upload all captured events to Keen
        KeenClient.client().upload(new UploadFinishedCallback() {
            public void callback() {
                // use this to notify yourself when the upload finishes, if you wish. we'll just log for now.
                Log.i("KeenAndroidSample", "Keen client has finished uploading!");
            }
        });

        super.onPause();
    }

If you want to call upload periodically during your application’s execution, you can do so by simply invoking KeenClient.upload() at any point.

---------
Debugging
---------

The Keen Android client code does a lot of logging, but it’s usually turned off by default. If you’d like to see the log lines generated by your usage of the client, you’ll need to enable logging.

.. code-block:: java

    KeenLogger.enableLogging();

Disabling logging is quite easy as well.

.. code-block:: java

    KeenLogger.disableLogging();

.. _Keen Android Client API Reference: https://keen.io/static/android-reference/index.html
.. _Keen IO User Chat: https://users.keen.io
