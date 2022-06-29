# Reference documentation

Looking to do something specific? You should find it here. If not, join [our Slack community](https://codecapsules.io/slack) to let us know and we'll get on it!

## General information

Take a look at how to [add a custom domain](./custom_domains/), how to [use a Procfile](./add-procfile-to-backend-application/) and how to [run database migrations](./migrating-a-database-with-code-capsules/)

## Deploying data capsules

Your capsules do not persist data by default as you might be used to from a VPS or your local machine. Every time they are restarted for any reason, they will pull a completely fresh copy of your code from GitHub. You can read more about persistence [here](./how-state-works/). If you want your application to persist data that is not in your repository, you should use one of our data capsules. You can find guides to set up different data capsules below.

### Deploying a MySQL data capsule

Follow our [MySQL data capsule set up guide](./set-up-mysql-data-capsule/) to set up a MySQL database for your Capsule.

### Deploying a MongoDB data capsules

Follow our [Mongo data capsule set up guide](./set-up-mongodb-data-capsule/) to set up a MongoDB database for your Capsule.

### Deploying a Redis data capsule

Follow our [Redis data capsule set up guide](./set-up-a-redis-data-capsule/) to set up Redis as a memory cache, queue, or anything else.

### Set up a Persistent Storage capsule

Follow our [File Data capsule set up guide](./set-up-file-data-capsule/) to set up a persistent storage capsule that behaves just like a local file system.

## Managing your Code Capsules account

You can find out more about [billing](./capsule-billing/), [managing your capsules](./capsule-management/), or [managing your team](./team-management/).
