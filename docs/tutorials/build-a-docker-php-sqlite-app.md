---
title: Building a Book Recommendations App with PHP, SQLite, and Docker
description: Create a full stack app that records book recommendations from users.
image: assets/tutorials/hex-color-identifier/hex-identifier.jpg
---

# Building a Book Recommendations App with PHP, SQLite, and Docker

PHP is one of the first technologies that made it possible to have dynamic web applications and has stood the test of time as it is still around today. In this tutorial, we’ll take a look at how to build a Docker container that contains a full stack book recommendations app built with php and SQLite.

Here’s what the final app will look like:

![Book Recommendation App](../assets/tutorials/docker-php-sqlite/app.png)

## Requirements

You will need the following to complete the tutorial and host your application on Code Capsules:

- A [Code Capsules](https://codecapsules.io/) account.
- Git set up and installed, and a registered [GitHub](https://github.com/) account.
- IDE or text editor of your choice.
- PHP installed.

## Project Set Up

Let’s start by creating a project folder which will house all our files.

In a terminal, navigate to the directory you'll be keeping the application files in. Run the commands below to create the project folder and navigate into it.

```
mkdir book-recommendations
cd book-recommendations
```

### Initialize an Empty Git Repository

From the project’s root folder, enter the command `git init` to initialize a git repository. This will allow you to track changes to your app as you build it.

### Linking to GitHub

Head over to [GitHub](https://github.com/) and create a new repository. Then, in your project's root folder, run the command below from the terminal, replacing "username" and "repository_name" with your own values from GitHub.

```bash
git remote add origin git@github.com:username/repository_name.git
```

This will link your local repository to the one on GitHub.

## Build the Frontend

Let’s begin by building our app’s index page which users will interact with. This page will have php and HTML as it’ll contain both static and dynamic content. Create a file named `index.php` in the project root folder and populate it with the code below:

```html
<?php  include('dbconfig.php'); ?>
<!DOCTYPE html>
<html>
  <head>
    <title>PHP SQLite</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
  </head>
  <body>
    <?php // Makes query with rowid
$query = "SELECT * FROM books";

$results = $dbh->query($query); ?>

    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Author</th>
          <th colspan="2">Action</th>
        </tr>
      </thead>

      <?php while ($row = $results->fetchArray()) { ?>
      <tr>
        <td><?php echo $row['name']; ?></td>
        <td><?php echo $row['author']; ?></td>
        <td>
          <a href="app.php?edit=<?php echo $row['id']; ?>" class="edit_btn"
            >Edit</a
          >
        </td>
        <td>
          <a href="app.php?del=<?php echo $row['id']; ?>" class="del_btn"
            >Delete</a
          >
        </td>
      </tr>
      <?php } ?>
    </table>

    <form method="post" action="app.php">
      <div class="input-group">
        <label>Name</label>
        <input type="text" name="name" value="" />
      </div>
      <div class="input-group">
        <label>Author</label>
        <input type="text" name="author" value="" />
      </div>
      <div class="input-group">
        <button class="btn" type="submit" name="save">Save</button>
      </div>
    </form>
  </body>
</html>
```

The first line references a database configuration file we’ll create at a later stage. For now, let’s explain how the frontend is built and gets its data. After including the `dbconfig.php` file there’s standard HTML and on line 6 we link to a stylesheet named `styles.css` responsible for making our frontend more visually appealing.

At the top of the `<body>` tag there is php code for getting a list of all the books from the database. To do this, we first assign the raw SQL query to a variable called `$query` and then run that query against the database and store the results in a variable called `$results`. Below this code there’s an HTML table that conditionally renders rows of book data depending on whether the `$results` variable is empty or not.

The last part of the index page is the input form that users will fill in to record their book recommendations. When a user clicks “Save” the form posts the data to a script named `app.php` which we’ll add in the backend section.

### Add Styling

Create a file named `styles.css` in the project root folder and add the code below to it:

```css
body {
  font-size: 19px;
}
table {
  width: 50%;
  margin: 30px auto;
  border-collapse: collapse;
  text-align: left;
}
tr {
  border-bottom: 1px solid #cbcbcb;
}
th,
td {
  border: none;
  height: 30px;
  padding: 2px;
}
tr:hover {
  background: #f5f5f5;
}

form {
  width: 45%;
  margin: 50px auto;
  text-align: left;
  padding: 20px;
  border: 1px solid #bbbbbb;
  border-radius: 5px;
}

.input-group {
  margin: 10px 0px 10px 0px;
}
.input-group label {
  display: block;
  text-align: left;
  margin: 3px;
}
.input-group input {
  height: 30px;
  width: 93%;
  padding: 5px 10px;
  font-size: 16px;
  border-radius: 5px;
  border: 1px solid gray;
}
.btn {
  padding: 10px;
  font-size: 15px;
  color: white;
  background: #5f9ea0;
  border: none;
  border-radius: 5px;
}
.edit_btn {
  text-decoration: none;
  padding: 2px 5px;
  background: #2e8b57;
  color: white;
  border-radius: 3px;
}

.del_btn {
  text-decoration: none;
  padding: 2px 5px;
  color: white;
  border-radius: 3px;
  background: #800000;
}
.msg {
  margin: 30px auto;
  padding: 10px;
  border-radius: 5px;
  color: #3c763d;
  background: #dff0d8;
  border: 1px solid #3c763d;
  width: 50%;
  text-align: center;
}
```

The code above adds styling to the index page. We won’t go over it as it is self explanatory and not really the point for this tutorial.

## Build the Backend

Next, we’ll build the backend for our app which will consist of the `dbconfig.php` and `app.php` files mentioned earlier.

### Configure SQLite

Create a file named `dbconfig.php` and add the following code to it:

```php
<?php
    class MyDB extends SQLite3
    {
    function __construct()
    {
        $this->open('first.db');
    }
    }
    $dbh = new MyDB();
    if(!$dbh){
    echo $dbh->lastErrorMsg();
    } else {
        $query = "CREATE TABLE IF NOT EXISTS books (id INT PRIMARY KEY, name STRING, author STRING)";
        $dbh->exec($query);
    }
?>
```

The code above connects to a sqlite database when the app is launched and creates a table called “books” if it doesn't already exist in the database.

### Add App Logic

Now add a file named `app.php` and populate it with the code below:

```php
<?php include('dbconfig.php');
    // initialize variables
	$name = "";
	$author = "";

	if (isset($_POST['save'])) {
		$name = $_POST['name'];
		$author = $_POST['author'];

        // Makes query with post data
        $query = "INSERT INTO books (name, author) VALUES ('$name', '$author')";
        $dbh->exec($query);
        $_SESSION['message'] = "Book saved";
        // header('location: index.php');
	}
?>
```

In the first line we include the `dbconfig.php` file so that we can access the database variable. The `if` statement checks to see if a `POST` request was made and if so, the code responsible for saving book information in that block executes. This is done by extracting the book name and author from the request and adding these variables to a raw SQL Insert statement. We then run the SQL statement against our database in order to save the book entry.

## Dockerize App

Our book recommendation app is now complete. We’re only left with containerizing it with Docker and then it’ll be ready to be shipped to Code Capsules. Let’s do this by adding a `Dockerfile` to the project root folder. A `Dockerfile` is a set of instructions on how to build an image of your application and run it inside a docker container. Populate the `Dockerfile` with the code below:

```dockerfile
FROM php:8.0-apache
WORKDIR /var/www/html

COPY . .
EXPOSE 80
```

Let’s take a look at how the image is built in the `Dockerfile`. In the first line we import the php 8 apache image which is what our image will be based on. Afterwards, we set `/var/www/html` as the working directory for the image that’ll be built shortly.

The third line copies everything in the project root folder into the working directory of the image. Lastly we expose the app in the image on port 80.

### Naming the `Dockerfile`

The name `Dockerfile` should start with a capital letter ‘D’ and have no extension, otherwise it won’t work.

## Add, Commit, and Push Git Changes

The application is now ready for deployment. Let's add and commit all the files we created to our local repository and then push them to the remote one. Do this by running the commands listed below in a terminal while in the project’s root folder:

```
git add -A
git commit -m "Added book recommendation app files"
git branch -M main
git push -u origin main
```

Your remote repository will now be up to date with your local one.

## Deploy to Code Capsules

The final step is to deploy our app. Log into your Code Capsules account and link your remote GitHub repository to Code Capsules. Create a Docker Capsule and deploy the app there. You can reference this [deployment guide](https://codecapsules.io/docs/deployment/how-to-deploy-flask-docker-application-to-production/#create-the-capsule) to see how to do so in greater detail.

Once the build is complete, navigate to the "Configure" tab and scroll down to the "Network Port" section. Enter "80" as the port number and click on "Update Capsule".

![Network Port](../assets/tutorials/docker-php-sqlite/network-port.png)

That’s it! Your "Book recommendations" app should be live and fully functional now. You should now be able to visit the index route.

![Book Recommendation App](../assets/tutorials/docker-php-sqlite/app.png)
