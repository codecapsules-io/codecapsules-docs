# How to Set Up a MySQL Data Capsule

Data capsules make it possible for your applications to have persistent storage. MySQL is one of the most popular database management systems available and in this tutorial we will look at how to create a MySQL data capsule and use it with applications hosted on Code Capsules and elsewhere.

## Create a MySQL Data Capsule

Log in to your Code Capsules account and navigate to the Space your MySQL data capsule will be contained in. Click "New Capsule" and select the "Data Capsule" option from the Create New Capsule dialog that slides in from the right. 

![Create Data Capsule](../assets/reference/create-data-capsule.png)

In the New Data Capsule dialog, choose "Mysql Database Cluster" as your data type, then click the "Create Capsule" button. 

![MySQL Database Cluster](../assets/reference/mysql-database-cluster.png)  

## Binding a Data Capsule to a Backend Capsule

To connect a data capsule to a backend capsule hosted on Code Capsules you need to bind the two together before you can connect to and use your data capsule. If you're not hosting your backend application on Code Capsules you can jump to [this section](#connecting-to-a-mysql-data-capsule-from-outside-code-capsules) as the binding step is not applicable in that use case.

Navigate to the backend capsule and click "Config" to open the capsule's config tab. Scroll down to the "Bind Data capsule" section where your recently created data capsule will show.

![Bind Data Capsule](../assets/reference/bind-mysql-data-capsule.png)

Click "Bind" to bind your data and backend capsules. During the bind process, Code Capsules creates a `DATABASE_URL` environmental variable to let your backend capsule know how to access services and features of your data capsule. Once the two capsules have been bound, you can scroll to the top of the Config tab to find the value of this variable. 

![Database url environment variable](../assets/reference/mysql-environment-variable.png)

We can use this database variable in code to read and write to our data capsule. Copy the value of the `DATABASE_URL` variable and append `/your_db_name?authSource=admin` to it as a query parameter. Make sure to replace `your_db_name` with the actual name of your database. This tells the data capsule to read and write to the specified database. If a database named `your_db_name` doesn't exist, the data capsule will create it. This allows you to have multiple databases in one data capsule.

### Connecting to a MySQL Data Capsule From a Python Application 

If your backend capsule is a Python application, use the following code to connect to your MongoDB Data Capsule:

```python
import os

data_capsule_url = os.getenv('DATABASE_URL')
database_one_url = data_capsule_url + "/database_one?authSource=admin"
production_database_url = data_capsule_url + "/production_database?authSource=admin"


### Do something with the db variable here

```

### Connecting to a MySQL Data Capsule From a Node.js Application 

If your backend capsule is a Node.js application, use the following code to connect to your MongoDB Data Capsule:

```js


```

## Connecting to a MySQL Data Capsule From Outside Code Capsules

If you're not hosting your backend application on Code Capsules you can still connect your data capsule to it. 

If public access to your data capsule is enabled, a connection string is visible below the "Public Access" switch, as shown in the above picture. Copy this connection string and paste it into your backend application's code to access your data capsule's services. Take note if you copy the connection string from the capsule it will already include the database name eg. in the screenshot above this part of the connection string `/app?ssl=true` includes the database name which is `app` in this case. 

### Connecting to a MySQL Data Capsule From an Externally Hosted Python Application 

If your backend application is written in Python, use the following code to connect to your MongoDB Data Capsule: 

```python

database_url = "<connection_string_here>" + "/database_one?authSource=admin"


### Do something with the db variable here

```

You'll notice in the code that we appended `/database_one?authSource=admin` to the connection string. This tells the data capsule to create a database with the name `database_one` if it doesn't exist, or to connect to it if it does. 
