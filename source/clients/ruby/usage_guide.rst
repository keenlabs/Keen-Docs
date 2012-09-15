=======================
Ruby Client Usage Guide
=======================

Introduction
------------

The Keen Ruby client is designed to be simple yet flexible. Our goal is to let you decide what events are important to you, use your own vocabulary to describe them, and decide when you want to send them to Keen service. If you're ready to start sending data to Keen, this guide will help you get started. You might also want to check out the :doc:`/getting_started_guide` and the :doc:`/event_data_modeling/event_data_intro`.

Installing the Keen Gem
It’s easy! Use this command line:

::

    gem install keen

Instrumenting your App
----------------------

This section of the guide shows you what code you need to add to your app in order to begin collecting event data.

First, load the required libraries by including this at the beginning of your program:

.. code-block:: ruby

    require 'rubygems'
    require 'keen'

Before doing this next step, login to Keen and get your project ID & auth token. These are automatically generated when you create a new Keen :ref:`project <projects>`. You can get this information anytime by going to your project settings page.

Define these variables in your program:

.. code-block:: ruby

    project_id = 'asdfasldkfjalsdkfalskdfj'
    auth_token = 'asldfjklj325tkl32jaskdlfjaf'

Next, setup the Keen client.  Here’s the beginner way to define the client:

.. code-block:: ruby

    keen = Keen::Client.new(project_id, auth_token)

Now, the fun part. Use *keen.add.event()* wherever you want to collect data.

For each event, specify an :ref:`event collection <event-collections>` name (e.g. “arrivals”), then include as many :ref:`properties <event-properties>` as you want (eg. landing page, referring source, browser, user properties).

Here’s a simple example that records someone’s arrival to your site:

.. code-block:: ruby

    keen.add_event("arrivals", {
        :landing page => “Bayside High Class of 1989 Chess Club fanpage”
        :referring_source => “google”,
        :browser => “Firefox 3.0”,
    })

Below is a more complex example for a purchase in a game. Notice how you can nest properties as shown in the “user” and “game” examples below, which each have properties of their own.

.. code-block:: ruby

    keen.add_event("purchases", {
      :quantity   => 1,
      :cost       => 1.50,
      :item       => “giant 80s cell phone”,
      :screen     => “vanity goods store”,
      :user       =>  {
            :name   => “Mark-Paul Gosselar”,
            :id     => 12342,
            :type   => “Premium”,
            :level  => 7,
            :age    => 38,
            :gender => “male”
        },
      :game  => {
            :name => “Saved By the Bell THE GAME”,
            :version => 2.5.3,
            :platform => “Facebook”
      },
      :sessionlength => 11:35:07,
      :browser => “Firefox 3.0”
    })

Use a local storage handler to batch events
-------------------------------------------

Using the default client properties, Keen will send your data each time an event fires. However, to minimize your API calls, we recommend that you batch your events. A free handler that we like a lot is called Redis. The configuration below describes how to use the “RedisHandler” which we built into the Keen ruby client.

To specify that you would like your events batched, set the cache_locally and storagemode properties when you define a new Keen client.

.. code-block:: ruby

    mykeenclient = Keen::Client.new(project_id, auth_token, :cache_locally => true, :storagemode => RedisHandler)

RedisHandler requires you to install `Redis <http://redis.io/>`_. It’s free and only takes a couple of minutes.

Sending your cached data to Keen
--------------------------------

If you’re using the cache_locally option, your data has to be sent to Keen explicitly. The

The command to send the data (regardless of storage handler) is:

.. code-block:: ruby

    worker = Keen::Async::Worker.new(client)
    result = worker.process_queue

Here’s an example program which uses the RedisHandler and sends the Redis client queue contents.

.. code-block:: ruby

    #Load the libraries required for Keen
    require 'rubygems'
    require 'keen'

    project_id = '4fdf5ae25g546f1b6a200003'
    auth_token = '97s79e30cb894628386f189ae539d12f'

    #Establish the Keen client
    client = Keen::Client.new(project_id, auth_token,
                :storage_class => Keen::Async::Storage::RedisHandler,
                :cache_locally => true)
                )




    # Process the jobs in the queue
    worker = Keen::Async::Worker.new(client)
    result = worker.process_queue


If you want to know the job queue length:

.. code-block:: ruby

    # How many jobs are there to process?
    count = client.storage_handler.count_active_queue
    puts "we have this many jobs: #{count}"


Example Ruby program with Keen
------------------------------

Below is a sample ruby program which is instrumented to send data to Keen.

.. code-block:: ruby

    #=======================================================================#
    # This little app asks a user a question and then replies to the user.
    # These events are captured in a single event which is sent to Keen.
    #=======================================================================#

    #Load the libraries required for Keen
    require 'rubygems'
    require 'keen'

    #Define properties for your unique Keen project. Get these from project settings page.
    project_id = '4fdf5ae25g546f1b6a200003'
    auth_token = '97s79e30cb894628386f189ae539d12f'

    #Define the Keen client.
    mykeenclient = Keen::Client.new(project_id, auth_token)

    #The first question the program asks (puts to the command line)
    creepy_greeting = "Hello gorgeous. What is your name?"
    puts creepy_greeting

    #This line captures the response from the user. STDIN.gets collects their response from the command line interface. Chomp trims off any extra spaces or carriage returns.
    user_name = STDIN.gets.chomp

    #This is the program's response to the user
    creepy_response = "Hi "+user_name+". You are my friend now. I'll be watching you. <3 <3 <3"
    puts creepy_response

    #Let's see how much the user likes the program after this interaction.
    puts 'How much do you like this program on a scale of 1-10? 10 means you really, really like it.'
    rating = STDIN.gets.chomp

    #Let’s store this information as an event. The Event Collection is called "creeperconvos". The event has four properties.

    mykeenclient.add_event("creeperconvos", {
                   :program_greeting => creepy_greeting,
                   :user_response => user_name,
                   :program_response => creepy_response,
                   :user_rating => rating,
                 })


This event was automatically sent to Keen when the add_event method was called. If you want to batch up events and send them asynchronously, checkout the Async storage class options!

After running your program, you data is immediately available in Keen. Login and check it out!

Example Program with Async event sending
----------------------------------------
Below is a sample ruby program which is instrumented to send data to Keen.

.. code-block:: ruby

    #======================#
    # This little app asks a user a question and then replies to the user.
    # These events are caputured in a single event and then send it to Keen.
    #======================#


    #Load the libraries required for Keen
    require 'rubygems'
    require 'keen'

    #Define properties for your unique Keen project. Get these from project settings page.
    project_id = '4fdf5ae25g546f1b6a200003'
    auth_token = '97s79e30cb894628386f189ae539d12f'

    #Define the Keen client. In this example we’ll use a storage handler.
    mykeenclient = Keen::Client.new(project_id, auth_token,
                :storage_class => Keen::Async::Storage::RedisHandler,
                :cache_locally => true,
            	:logging => false
                )


    #The first question the program asks (puts to the command line)
    creepy_greeting = "Hello gorgeous. What is your name?"
    puts creepy_greeting

    #This line captures the response from the user. STDIN.gets collects their response from the command line interface. Chomp trims off any extra spaces or carriage returns.
    user_name = STDIN.gets.chomp

    #This is the program's response to the user
    creepy_response = "Hi "+user_name+". You are my friend now. I'll be watching you. <3 <3 <3"
    puts creepy_response

    #Let's see how much the user likes the program after this interaction.
    puts 'How much to you like this program on a scale of 1-10? 10 means you really, really like it.'
    rating = STDIN.gets.chomp

    #Let’s store this information as an event. The Event Collection is called "creeperconvos". The event has four properties.

    mykeenclient.add_event("creeperconvos", {
                   :program_greeting => creepy_greeting,
                   :user_response => user_name,
                   :program_response => creepy_response,
                   :user_rating => rating,
                 })

    # Since we have opted to use the RedisStorageHandler, the above event is now stored in Redis.
    # Now we need to send those events to Keen by invoking the Worker.

    worker = Keen::Async::Worker.new(mykeenclient)
    result = worker.process_queue

After running your program, your data is immediately available in Keen. Login and check it out!