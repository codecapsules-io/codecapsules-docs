# Reference Documentation

Looking to do something specific? You should find it here. If not, join [our Slack community](https://codecapsules.io/slack) to let us know and we'll get on it!

## General Information

Take a look at how to [add a custom domain](./custom_domains/), how to [use a Procfile](./add-procfile-to-backend-application/), and how to [run database migrations](./migrating-a-database-with-code-capsules/)

## Deploying Data Capsules

Your Capsules do not persist data by default as you might be used to from a VPS or your local machine. Every time they are restarted for any reason, they will pull a completely fresh copy of your code from GitHub. You can read more about persistence [here](./how-state-works/). If you want your application to persist data that is not in your repository, you should use one of our Data Capsules. You can find guides to set up different Data Capsules below.

### Deploying a MySQL Data Capsule

Follow our [MySQL Data Capsule set up guide](./set-up-mysql-data-capsule/) to set up a MySQL database for your Capsule.

### Deploying a MongoDB Data Capsule

Follow our [MongoDB Data Capsule set up guide](./set-up-mongodb-data-capsule/) to set up a MongoDB database for your Capsule.

### Deploying a Redis Data Capsule

Follow our [Redis Data Capsule set up guide](./set-up-a-redis-data-capsule/) to set up Redis as a memory cache, queue, or anything else.

### Set up a Persistent Storage Capsule

Follow our [File Data Capsule set up guide](./set-up-file-data-capsule/) to set up a persistent storage Capsule that behaves just like a local file system.

## Managing your Code Capsules Account

You can find out more about [billing](./capsule-billing/), [managing your Capsules](./capsule-management/), or [managing your Team](./team-management/).
