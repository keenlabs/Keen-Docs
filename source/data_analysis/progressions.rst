============
Progressions
============

A Progression is a flow of events that a user performs on their way to reaching a goal.  This flow could be a checkout process, registration, or lead conversion.  When analyzing a Progression, you are concerned with the number of users that successfully make it to the next step as well as the number of users that drop off.  This will show you where your flow loses the most users so you know where to focus your attention.  The result from a progression is a list of counts for each of the steps you specify.

For example, your progression could have these steps:

1. Successful completion of an app’s tutorial.
2. Creation of content in the app.
3. Sharing of content with another user.

A progression analysis with those steps would work like this:

1. Count the number of unique users who completed the app’s tutorial.
2. Of the users who were counted in step 1, count the number of them who created content.
3. Of the users who were counted in step 2, count the number of them who shared content.

Progressions are performed by sending an HTTP GET request to a URL of the following form:

.. code-block:: none

    https://api.keen.io/3.0/projects/<project_id>/probes/progression?api_key=<api_key>&steps=<[step1, step2, step3...]>

Progressions take in the following parameters:

* **api_key** (optional) - The API key for the project containing the data you are analyzing.
* **steps** (required) - A URL encoded JSON array defining the :ref:`steps` in the Progression.  See the Steps section below for details.

.. _steps:

Steps
-----

A step is defined as an event or set of events that meet a given criteria.  Your first step, along with any filters that you provide, determine the starting data set of your progression. Each step includes something called an actor_property --- typically a user id -- that specifies the important thing you want to count in that step. Continuing our example, the first step would count the number of unique user ids in the event collection “Tutorial Completions”.

To create a Progression, you must define each of its steps.  A step is a JSON object with the following parameters:

* **event_name** (required) - a string containing the name of the event that defines the step.
* **actor_property** (required) - a string containing the name of the property that can be used as a unique identifier for a user (or any type of actor).
* **timeframe** (optional) - A :doc:`timeframe` specifies the events to use for analysis based on a window of time.
* **filters** (optional) - :doc:`filters` are used to narrow the scope of events used in this step of the progression.

Each step of your Progression should be be inserted into a JSON array and URL encoded. Then you simply set the “steps” parameter in your query string.

In this example, we want to find the drop off rate between users viewing our landing page and signing up for our service.  Note that timeframes are not specified, so it will be using all the data ever recorded for these two events.  Here is what the steps would look like in JSON form.

.. code-block:: none

    [
       {
          “event_name”:”view_landing_page”,
          ”actor_property”:”body:user:id”
       },
       {
          “event_name”:”sign_up”,
          ”actor_property”:”body:user:id”
       }
    ]

Here is what that JSON string looks like after URL encoding it:

.. code-block:: none

    %5b%7b%22event_name%22%3a%22view_landing_page%22%2c%22actor_property%22%3a%22body%3auser%3aid%22%7d%2c%7b%22event_name%22%3a%22sign_up%22%2c%22actor_property%22%3a%22body%3auser%3aid%22%7d%5d

Finally, set that string equal to the **step** parameter in your query string.

The response from a Progression analysis looks like this:


.. code-block:: none

   
   {
       “results”:[
           9375,
           203
       ],
       ”steps”:[
           {
              “event_name”:”view_landing_page”,
              ”actor_property”:”body:user:id”
           },
           {
              “event_name”:”sign_up”,
              ”actor_property”:”body:user:id”
           }
       ]
   }
   

The results array details the number of users that successfully made it to each step in the Progression.  The **steps** array contains the definition of the steps passed in via the query string parameter.