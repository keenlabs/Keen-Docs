====================
Data Collection APIs
====================

We built a massively scalable event data warehouse so that you can send us whatever data you want without having to worry about storage or performance.

Our public REST API lets you send data using standard HTTP POST methods, from any device. Try it out really quickly using cURL in our :doc:`/getting-started-guide`.

Our SDKs make integration even simpler. Check out our client usage guides for the steps to integrate your app for data collection: 

* :doc:`iOS guide </clients/iOS/usage-guide>` | `SDK <http://keen.io/static/code/KeenClient.zip>`_
* :doc:`javascript guide </clients/javascript/usage-guide>` | `SDK <https://keen_web_static.s3.amazonaws.com/code/keenio-1.0.0.js>`_
* :doc:`android guide </clients/android/usage-guide>` | `SDK <http://keen.io/static/code/KeenClient-Android.jar>`_
* :doc:`ruby guide </clients/ruby/usage-guide>` | `gem install keen <https://github.com/keenlabs/KeenClient-Ruby>`_

Here are the links to the REST API resources for data collection:

* :ref:`event-collection-resource` - Used for bulk-inserting events into Keen.
* :ref:`event-resource` - Used for inserting single events into Keen.



