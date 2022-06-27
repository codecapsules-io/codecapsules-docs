# How to Set Up a Redis Data Capsule

In this tutorial, we’ll create a Redis Data Capsule to provide low latency, in-memory data storage for your application hosted on Code Capsules.

## Create a Redis Data Capsule

Log in to your Code Capsules account and navigate to the Space your Redis Capsule will be contained in. Click “New Capsule". In the Create New Capsule dialog, select "Data Capsule".

![CreateDataCapsule](../assets/tutorials/redis_queue/create_data_capsule.png)

Select "Redis Memory Cache" from the list of data types, and click "Create Capsule".

![SelectDatabase](../assets/tutorials/redis_queue/select_database.png)

## Binding a Data Capsule to a Backend Capsule

Now we need to bind our Data Capsule to a Backend Capsule. Navigate to your Backend Capsule and click the "Configure" option on the menu. Scroll down to the “Bind Data Capsule” section and click “Bind”.

![BindCapsule](../assets/tutorials/redis_queue/bind_redis_capsule.png)

During the “Bind” process, Code Capsules creates a `REDIS_URL` environment variable which will let your application connect to your Redis database. Once the Capsules have been bound, you can find the variable under the "Configure" tab, in the "Capsule parameters" section.

![RedisUrl](../assets/tutorials/redis_queue/redis_url.png)

We'll use this environment variable in our app to connect to the database.


## Connecting to a Redis Data Capsule from a Python Application

If your Backend Capsule is a Python application, use the following code to connect to your Redis database:

```python
import os
import redis

redis_url = os.getenv('REDIS_URL')

connection = redis.from_url(redis_url)

# Do something here
```

## Connecting to a Redis Data Capsule from a Node.js Application

If your Backend Capsule is a Node.js application, use the following code to connect to your Redis database:

```js
let redis = require('redis');
let redis_url = process.env.DATABASE_URL

let connection = redis.createClient({
  url: redis_url
});

connection.connect();

// Do something here 

connection.quit();
```
