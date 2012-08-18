========
Projects
========

The first step in integrating your application with Keen is the creation of a Project. You can think of a project as a data silo - the data in a Project is completely separate from data in other projects.

There are a few scenarios where it makes sense to create multiple projects to logically separate data:

* If you have more than one application, create a separate project for each app. For example you might have a project called Eat My Shorts App and another one called CraftMine App.
* You probably have a production environment and a test environment. It’s a good idea to separate that data to avoid accidentally polluting your production data store with test data. Continuing our example, you would have 4 projects:
    * Eat My Shorts App - Staging
    * Eat My Shorts App - Prod
    * CraftMine - Staging
    * CraftMine - Prod
* If you run your app on multiple platforms --- iOS and Android for example --- we recommend storing that data in a shared project rather than creating separate projects. Having your iOS and Android events in a single project will make it much easier to do analysis across platforms. You’ll be able to ask questions like “how many people are using our app? How many people are using our new feature?”. You can always use filters to do comparisons between the platforms --- just make sure you include a platform property when sending data.
* If you have an application with many similar instances, for example an app for restaurants with a different version for each restaurant, `email us`_ and we will help you figure out the best way to structure your projects. There may be cases where you want to logically separate data for different companies while at the same time requiring cross-project analysis -- we can help!

.. _email us: team@keen.io