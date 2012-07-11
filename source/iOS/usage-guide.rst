Keen iOS Client Usage Guide
===========================

============
Introduction
============

The Keen iOS client is designed to be simple to develop with, yet incredibly flexible. Our goal is to let you decide what events are important to you, use your own vocabulary to describe them, and decide when you want to send them to Keen service.

=============
Install Guide
=============

-----------
From Source
-----------

The Keen iOS clients source is available on GitHub: https://github.com/keenlabs/KeenClient-iOS

^^^^^^^^^^^^^^^^^
Clone the Project
^^^^^^^^^^^^^^^^^

Clone the project locally: ::

  git clone --recursive https://github.com/keenlabs/KeenClient-iOS
  
The --recursive modifier is set because the client includes sub-modules.

You could also add the project as a sub-module to your own git project: ::

  git submodule add https://github.com/keenlabs/KeenClient-iOS
  git submodule update --recursive --init

^^^^^^^^^
Run Tests
^^^^^^^^^

This is optional but probably a good idea to make sure everything is working as expected. Open up the Keen client workspace file (KeenClient.xcworkspace).

Make sure the KeenClient scheme is selected, with the target device as a simulator.

.. image:: https://keen.io/static/img/docs/ios_client_usage_guide/target_device.png

Then try to run all the tests for the project by going to the Product menu in Xcode and selecting Test (or just hit ⌘+U on your keyboard). If all goes well, the code should compile and all the tests should pass.

^^^^^^^^
Add Code
^^^^^^^^

Add the correct code to your XCode project.  There are a few important files: ::

  /KeenClient/KeenClient.h
  /KeenClient/KeenClient.m
  /KeenClient/KeenConstants.h
  /KeenClient/KeenConstants.m
  /JSONKit/JSONKit.h
  /JSONKit/JSONKit.m
  /iso-8601-parser-unparser/ISO8601DateFormatter.h
  /iso-8601-parser-unparser/ISO8601DateFormatter.m

Start by creating a new group in your project:

.. image:: https://keen.io/static/img/docs/ios_client_usage_guide/new_group.png

Rename the group to whatever you want. I’ve chosen "KeenClient". Now you’ll want to drag all the files outlined above from Finder into XCode, under that group. Here’s an example:

.. image:: https://keen.io/static/img/docs/ios_client_usage_guide/drag_files.png

Make sure the "Copy items into destination group’s folder..." option is selected.

^^^^^^^^^^^^^^
If You Use ARC
^^^^^^^^^^^^^^

This should only be done if your project uses ARC (Automatic Reference Counting).

The source code does not use ARC currently, in order to be backwards-compatible with older code. This will change in the future as ARC gains traction in the developer community. Because of this, if your project uses ARC, you’ll need to set specific compiler settings so that the Keen code is treated correctly. Select your target and make sure the "Build Phases" tab is selected. Then add the compiler flag "-fno-objc-arc" to the .m files you just dragged in. By the end, it should look something like this:

.. image:: https://keen.io/static/img/docs/ios_client_usage_guide/arc.png

^^^^^^^^^^^^^^^^^^^^
Add KCLog Definition
^^^^^^^^^^^^^^^^^^^^

Now you need to add a definition for KCLog to your project's prefix file. KCLog is a custom logging method that the Keen Client uses. It exists so that you can choose whether or not to enable internal logging from the Keen Client (useful when sending debugging issues to us). Open up your project's \*-Prefix.pch file, and add the following after whatever is in there already: ::

  #define KEEN_DEBUG

  #ifdef KEEN_DEBUG
      #define KCLog(...) NSLog(__VA_ARGS__)
  #else
      #define KCLog(...)
  #endif

^^^^^^^
Compile
^^^^^^^

Finally, try and compile. If all goes well, the compile should be clean! It took a bit of work, but now you can easily pull updates from the open source community and have those changes reflected in your project. But if you don’t want to go through the hassle, there’s an easier way.

----------------
Universal Binary
----------------

Instead of including source and having to compile it yourself, you can simply download the latest universal binary for the client from Keen. This binary will work on both simulators and devices.

^^^^^^^^
Download
^^^^^^^^

Download the binary and public headers. Get the latest from here:

http://keen.io/static/code/KeenClient.zip

^^^^^^^^^^
Uncompress
^^^^^^^^^^

Uncompress the archive. It should contain two files:

libKeenClient-Aggregate.a
KeenClient.h

.. image:: https://keen.io/static/img/docs/ios_client_usage_guide/add_from_archive.png

^^^^^^^^^^^^^^^^^^
Add Files to Xcode
^^^^^^^^^^^^^^^^^^ 

Add these two files from Finder into Xcode.

^^^^^^^^^^^^^^^^^^
Enable Linker Flag
^^^^^^^^^^^^^^^^^^

Enable a linker flag to include the special categories on some of the NSFoundation classes that are required for the Keen client to work correctly. Start by choosing the correct target for your project, selecting the "Build Settings" tab, and then search for "other linker". Under "Other Linker Flags", add the text "-ObjC".

.. image:: https://keen.io/static/img/docs/ios_client_usage_guide/categories.png

^^^^^^^
Compile
^^^^^^^

Try and compile. It should work!

===========
Usage Guide
===========

---------------
Instrumentation
---------------

By this point, you should have either included the Keen client code from source or from a universal binary. Now it’s time to actually use the code!

^^^^^^^^^^^^^^^
Register Client
^^^^^^^^^^^^^^^

Register the KeenClient shared client with your project ID and authorization token. The recommended place to do this is in one of your application delegates. Here’s some example code: ::

  - (void)applicationDidBecomeActive:(UIApplication *)application
  {
      [KeenClient sharedClientWithProjectId:@"4f4ed092163d663d3a000000" 
                               andAuthToken:@"9a9d92907c3e43c3a4742535fc2f78ec"];
  }
  
The [KeenClient sharedClientWithProjectId: andAuthToken] does the registration. From now on, in your code, you can just reference the shared client by calling [KeenClient sharedClient].

^^^^^^^^^^
Add Events
^^^^^^^^^^

Add events to track. Here’s a very basic example for an app that includes two tabs. We want to track when a tab is switched to. ::

  - (void)viewWillAppear:(BOOL)animated
  {
      [super viewWillAppear:animated];

      NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:@"first view", @"view_name",
                             @"going to", @"action", nil];
      [[KeenClient sharedClient] addEvent:event toCollection:@"tab_views"];
  }
  
The idea is to first create an arbitrary dictionary of JSON-serializable values. We support: ::

  NSString, NSNumber, NSDate, NSDictionary, NSArray, and BOOL

Keys must be alphanumeric, with the exception of the underscore (_) character, which can appear anywhere but the beginning of the string. For example, "view_name" is allowed, but "_view_name" is not.

Add as many events as you like. The Keen client will cache them on disk until you’re ready to send them.

The client will automatically stamp every event you track with a timestamp. If you want to override the system value with your own, use the following example. Note that the "timestamp" key is set in the header properties dictionary. ::

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
                             toCollection:@"tab_views"];
  }

^^^^^^^^^^^^^^
Upload to Keen
^^^^^^^^^^^^^^

Upload the captured events to the Keen service. This must be done explicitly. We recommend doing the upload when your application is sent to the background, but you can do it whenever you’d like (for example, if your application typically has very long user sessions). The uploader spawns its own background thread so the main UI thread is not blocked. ::

  - (void)applicationDidEnterBackground:(UIApplication *)application
  { 
      UIBackgroundTaskIdentifier taskId = [application 
    beginBackgroundTaskWithExpirationHandler:^(void) {
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

