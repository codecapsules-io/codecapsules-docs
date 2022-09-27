---
title: Building a Book Recommendations App with PHP, SQLite, and Docker
description: Create a full stack app that records book recommendations from users.
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
<?php  include('dbconfig.php'); 

	// initialize variables
	$name = "";
	$author = "";
	$update = false;

	if (isset($_GET['edit'])) {
		$id = $_GET['edit'];
		$update = true;
		$query = "SELECT rowid, name, author FROM books WHERE rowid=$id";
		$result = $dbh->query($query); $entry = $result->fetchArray(); $name =
$entry['name']; $author = $entry['author']; } ?>
<!DOCTYPE html>
<html>
  <head>
    <title>PHP SQLite</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
  </head>
  <body>
    <?php // Makes query with rowid
$query = "SELECT rowid, name, author FROM books";

$results = $dbh->query($query); ?>

    <h1>Book Recommendations</h1>

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
          <a href="index.php?edit=<?php echo $row['rowid']; ?>" class="edit_btn"
            >Edit</a
          >
        </td>
        <td>
          <a href="app.php?del=<?php echo $row['rowid']; ?>" class="del_btn"
            >Delete</a
          >
        </td>
      </tr>
      <?php } ?>
    </table>

    <form method="post" action="app.php">
      <input type="hidden" name="id" value="<?php echo $id; ?>" />
      <div class="input-group">
        <label>Name</label>
        <input type="text" name="name" value="<?php echo $name; ?>" />
      </div>
      <div class="input-group">
        <label>Author</label>
        <input type="text" name="author" value="<?php echo $author; ?>" />
      </div>
      <div class="input-group">
        <?php if ($update == true): ?>
        <button
          class="btn"
          type="submit"
          name="update"
          style="background: #556B2F;"
        >
          Update
        </button>
        <?php else: ?>
        <button class="btn" type="submit" name="save">Save</button>
        <?php endif ?>
      </div>
    </form>
  </body>
</html>
```

The first part of the snippet is php responsible for making the page dynamic. We do this by first referencing a database configuration file we’ll create at a later stage. This will allow us to read book entries from the database. The `if` block checks to see if there's an entry being edited and if so updates the input form to show values for the book being edited. Next, let’s look at how the frontend is built and gets its data.

At the top of the `<body>` tag there is php code for getting a list of all the books from the database. To do this, we first assign the raw SQL query to a variable called `$query` and then run that query against the database and store the results in a variable called `$results`. Below this code there’s an HTML table that conditionally renders rows of book data depending on whether the `$results` variable is empty or not.

The last part of the index page is the input form that users will fill in to record their book recommendations. Depending on the value of the `$update` variable defined at the top of the file the form conditionally renders a either a "Save" or "Update" button. When a user submits the form it posts the data to a script named `app.php` which will either save a new book entry or update an existing one depending on whether the post request was triggered by the "Save" or "Update" button. We'll add the `app.php` script in the backend section.

### Add Styling

Create a file named `styles.css` in the project root folder and add the code below to it:

```css
body {
  font-size: 19px;
}
h1 {
  text-align: center;
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
        $this->open($_ENV["PERSISTENT_STORAGE_DIR"] . '/combadd.sqlite');
    }
    }
    $dbh = new MyDB();
    if(!$dbh){
    echo $dbh->lastErrorMsg();
    } else {
        $query = "CREATE TABLE IF NOT EXISTS books (name STRING, author STRING)";
        $dbh->exec($query);
    }
?>
```

The code above connects to a sqlite database when the app is launched and creates a table called “books” if it doesn't already exist in the database.

### Add App Logic

Now add a file named `app.php` and populate it with the code below:

```php
<?php include('dbconfig.php');

    if (isset($_GET['del'])) {
        $id = $_GET['del'];
        $query = "DELETE FROM books WHERE rowid=$id";
		    $dbh->exec($query);
        header('location: index.php');
    }

	if (isset($_POST['update'])) {
		$id = $_POST['id'];
		$name = $_POST['name'];
		$author = $_POST['author'];

		$query = "UPDATE books SET name='$name', author='$author' WHERE rowid=$id";
		$dbh->exec($query);
		header('location: index.php');
	}

	if (isset($_POST['save'])) {
		$name = $_POST['name'];
		$author = $_POST['author'];

    // Makes query with post data
    $query = "INSERT INTO books (name, author) VALUES ('$name', '$author')";
    $dbh->exec($query);
    header('location: index.php');
	}
?>
```

In the first line we include the `dbconfig.php` file so that we can access the database variable. There are three `if` blocks each responsible for either deleting, updating or saving a book entry. Let's go over each of them:

The first `if` statement executes if a delete request was sent from the frontend. In that case, the code block gets the unique `id` of the book to be deleted from the request and uses it in a `DELETE` SQL query to specify which book should be deleted.

In the event that a user is updating a book entry the second `if` statement executes. The book entry is updated by first getting the new values and `id` so the code knows which book is being updated. After which, the new values are injected in a `UPDATE` SQL query which is then run on the database in order to update the book entry.

Finally, the last `if` statement checks to see if a save request was made and if so, the new book entry is saved. This is done by extracting the book name and author from the request and adding these variables to a raw SQL `INSERT` statement. We then run the SQL statement against our database in order to save the book entry. Afterwards we redirect the app to the index page by setting the location header tag.

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

### Create a Data Capsule

Our Book Recommendations app needs a Data Capsule in order to persistently store book entries. Create a persistent storage Data Capsule in the same Space where you have your Docker Capsule and bind the two capsules together. You can reference this [guide](https://codecapsules.io/docs/reference/set-up-file-data-capsule/) to see how to do so in more detail.

### View App

That’s it! Your "Book Recommendations" app should be live and fully functional now. To visit the index route, click the "Live Website" link at the top right of your Docker Capsule.

![Book Recommendation App](../assets/tutorials/docker-php-sqlite/app.png)
