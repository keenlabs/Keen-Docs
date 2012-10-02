======================
iOS Client Usage Guide
======================

Introduction
============

The Keen iOS client is designed to be simple to develop with, yet incredibly flexible. Our goal is to let you decide what events are important to you, use your own vocabulary to describe them, and decide when you want to send them to Keen service.

For a detailed class reference, please visit our `Keen iOS Client API Reference`_.

* :ref:`install-guide` - How to install the Keen iOS Client into your application.
* :ref:`register-client` - How to register your project ID and API key with the Keen iOS Client.
* :ref:`add-events` - How to add an event with the Keen iOS Client.
* :ref:`upload-events` - How to upload all previously saved events with the Keen iOS Client.

---------------------------
Get Project ID & Auth Token
---------------------------

If you haven't done so already, login to `Keen.io <http://keen.io/login>`_ to generate a :ref:`project <projects>` for your app. Select "+ Create a new project" from the projects drop down in the upper left navigation.

.. _install-guide:

Install Guide
=============

Installing the client should be a breeze. If it's not, please let us know at team@keen.io!

----------------
Universal Binary
----------------

Our recommended way of installing the Keen Client is to use the universal binary we've created. With this, you'll be able to instrument your app regardless of whether or not it uses ARC (Automatic Reference Counting) or if you have a different version of JSONKit than the one we rely on.

.. note:: While we think the universal binary makes things really easy, we love to be transparent. Come check out our work on GitHub at https://github.com/keenlabs/KeenClient-iOS. We love feedback, especially in the form of pull requests. :)

^^^^^^^^
Download
^^^^^^^^

Download the binary and public headers. Get the latest from here:

http://keen.io/static/code/KeenClient.zip

^^^^^^^^^^
Uncompress
^^^^^^^^^^

Uncompress the archive. It should contain a folder called "KeenClient" with two files:

* libKeenClient-Aggregate.a
* KeenClient.h

^^^^^^^^^^^^^^^^^^
Add Files to Xcode
^^^^^^^^^^^^^^^^^^ 

Just drag the "KeenClient" folder into your Xcode project.

^^^^^^^^^^^^^^^^^^
Enable Linker Flag
^^^^^^^^^^^^^^^^^^

Enable a linker flag to include the special categories on some of the NSFoundation classes that are required for the Keen client to work correctly. Start by choosing the correct target for your project, selecting the "Build Settings" tab, and then search for "other linker". Under "Other Linker Flags", add the text "-ObjC".

.. image:: https://keen.io/static/img/docs/ios_client_usage_guide/categories.png

^^^^^^^
Compile
^^^^^^^

Try and compile. It should work! If it doesn't, you probably forgot to enable the linker flag (see above). If you still can't get it to work, let us know at team@keen.io and one of us will help you right away.


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

Register the KeenClient shared client with your project ID and authorization token. The recommended place to do this is in one of your application delegates. Here’s some example code: 

.. code-block:: objc

  - (void)applicationDidBecomeActive:(UIApplication *)application
  {
      [KeenClient sharedClientWithProjectId:@"4f4ed092163d663d3a000000" 
                                  andApiKey:@"9a9d92907c3e43c3a4742535fc2f78ec"];
  }
  
The [KeenClient sharedClientWithProjectId: andApiKey] does the registration. From now on, in your code, you can just reference the shared client by calling [KeenClient sharedClient].

.. _add-events:

^^^^^^^^^^
Add Events
^^^^^^^^^^

Add events to track. Here’s a very basic example for an app that includes two tabs. We want to track when a tab is switched to.

.. code-block:: objc

  - (void)viewWillAppear:(BOOL)animated
  {
      [super viewWillAppear:animated];
      
      NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:@"first view", @"view_name",
                             @"going to", @"action", nil];
      [[KeenClient sharedClient] addEvent:event toCollection:@"tab_views" error:nil];
  }
  
The idea is to first create an arbitrary dictionary of JSON-serializable values. We support: ::

  NSString, NSNumber, NSDate, NSDictionary, NSArray, and BOOL
  
.. note:: The JSON spec doesn't include anything about date values. At Keen, we know dates are important to track. Keen sends dates back and forth through its API in ISO-8601 format. The Keen Client handles this for you.

Keys must be alphanumeric, with the exception of the underscore (_) character, which can appear anywhere but the beginning of the string. For example, "view_name" is allowed, but "_view_name" is not.

Add as many events as you like. The Keen client will cache them on disk until you’re ready to send them.

The client will automatically stamp every event you track with a timestamp. If you want to override the system value with your own, use the following example. Note that the "timestamp" key is set in the header properties dictionary.

.. code-block:: objc

  - (void)viewWillAppear:(BOOL)animated
  {
      [super viewWillAppear:animated];

      NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:@"first view", @"view_name",
                             @"going to", @"action", nil];
      NSDate *myDate = [NSDate date];
      NSDictionary *headerProperties = [NSDictionary dictionaryWithObject:myDate
                                                                   forKey:@"timestamp"];
      [[KeenClient sharedClient] addEvent:event
                     withHeaderProperties:headerProperties
                             toCollection:@"tab_views"
                                    error:nil];
  }
  
^^^^^^^^^^^^^^^^^
Global Properties
^^^^^^^^^^^^^^^^^

Now you might be thinking, "Okay, that looks pretty easy. But what if I want to send the same properties on EVERY event in a particular collection? Or just EVERY event, period?" We've got you covered through something we call Global Properties. 

Global properties are properties which are sent with EVERY event. For example, you may wish to always capture device information like OS version, handset type, orientation, etc.

There are two ways to handle Global Properties - one is more simple but more limited, while the other is a bit more complex but much more powerful. For each of them, after you register your client, you'll need to set an Objective-C property on the KeenClient instance you're using. 

**Dictionary-based Global Properties**

For this, the Objective-C property is called *globalPropertiesDictionary*. The property's value will be an *NSDictionary* that you define. Each time an event is added, the iOS client will look at the value of this property and add all its contents to the user-defined event. Use this if you have a bunch of static properties that you want to add to every event.

Here's an example using a dictionary:

.. code-block:: objc

  - (void)applicationDidBecomeActive:(UIApplication *)application
  {
      [KeenClient sharedClientWithProjectId:@"4f4ed092163d663d3a000000" 
                                  andApiKey:@"9a9d92907c3e43c3a4742535fc2f78ec"];
      client.globalPropertiesDictionary = @{@"some_standard_key": @"some_standard_value"};
  }

.. note:: If there are two properties with the same name specified in the user-defined event AND the global properties, the user-defined event's property will be the one used.

**Block-based Global Properties**

For this, the Objective-C property is called *globalPropertiesBlock*. The property's value will be a block that you define. Every time an event is added, the block will be called. The client expects the block to return an NSDictionary consisting of the global properties for that event collection. Use this if you have a bunch of dynamic properties (see below) that you want to add to every event.

Here's an example using blocks:

.. code-block:: objc

  - (void)applicationDidBecomeActive:(UIApplication *)application
  {
      [KeenClient sharedClientWithProjectId:@"4f4ed092163d663d3a000000" 
                                  andApiKey:@"9a9d92907c3e43c3a4742535fc2f78ec"];
      client.globalPropertiesBlock = ^NSDictionary *(NSString *eventCollection) {
          if ([eventCollection isEqualToString:@"apples"]) {
              return @{ @"color": @"red" };
          } else if ([eventCollection isEqualToString:@"pears"]) {
              return @{ @"color": @"green" };
          } else {
              return nil;
          }
      };
  }
  
The block takes in a single string parameter which corresponds to the name of this particular event. And we expect it to return an NSDictionary of your construction. This example doesn't make use of the parameter, but yours could!

.. note:: Because we support a block here, you can create DYNAMIC global properties. For example, you might want to capture the orientation of the device, which obviously could change at run-time. With the block, you can use functional programming to ask the OS what the current orientation is, each time you add an event. Pretty useful, right?

.. note:: Another note - you can use BOTH the dictionary property AND the block property at the same time. If there are conflicts between defined properties, the order of precedence is: user-defined event > block-defined event > dictionary-defined event. Meaning the properties you put in a single event will ALWAYS show up, even if you define the same property in one of your globals.

.. _upload-events:

^^^^^^^^^^^^^^
Upload to Keen
^^^^^^^^^^^^^^

Upload the captured events to the Keen service. This must be done explicitly. We recommend doing the upload when your application is sent to the background, but you can do it whenever you’d like (for example, if your application typically has very long user sessions). The uploader spawns its own background thread so the main UI thread is not blocked.

.. code-block:: objc

  - (void)applicationDidEnterBackground:(UIApplication *)application
  { 
      UIBackgroundTaskIdentifier taskId = [application beginBackgroundTaskWithExpirationHandler:^(void) {
          NSLog(@"Background task is being expired.");
      }];
    
      [[KeenClient sharedClient] uploadWithFinishedBlock:^(void) {
          [application endBackgroundTask:taskId];
      }];
  }

In this example, the upload is done in a background task so that even once the user backgrounds your application, the upload can continue. Here we first start the background task, start the upload, and then end the background task once the upload completes.

If you want to call upload periodically during your application’s execution, you can do so by simply invoking [KeenClient uploadWithFinishedBlock:] at any point.

---------
Debugging
---------

The Keen iOS client code does a lot of logging, but it’s usually turned off by default. If you’d like to see the log lines generated by your usage of the client, you’ll need to enable a Preprocessor Macro in your Build Settings in Xcode. Here’s a screenshot:

.. image:: https://keen.io/static/img/docs/ios_client_usage_guide/macro.png

As you can see, you’ll want to add a macro for Debug mode called KEEN_DEBUG and set its value to 1. If you want to disable the log lines, simply remove the macro or set its value to 0.

.. _Keen iOS Client API Reference: https://keen.io/static/iOS-reference/index.html