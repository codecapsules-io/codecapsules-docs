---
title: Add a Procfile to a Backend Application
description: Write a Procfile for your backend application to outline how it should be run
---

# Add a Procfile to a Backend Application

Procfiles communicate to the backend capsule, what processes it needs to run and in which order to execute them for your application to be successfully deployed.

## Procfile Naming and Location

A Procfile is a simple text file named `Procfile` exactly and should not have any extensions like `.txt` or `.py`. It should also be noted that naming the file `procfile` will not work either as it is case sensitive. 

Procfiles should always be located in the root folder of the project. They won't work in any other location.

## Procfile Processes 

The type of processes a backend capsule needs to run before deploying a backend application are outlined in the `Procfile`. Common processes include but are not limited to `web`, `worker` and `clock` processes. When declaring a process type, you should also write the command to run for that particular process.

A process type command allows you to specify on which port you'd like the process to run and other different options which are process specific. 

## Procfile Format

The Procfile's format is a key value listing of process types and their commands on each line as shown below. 

```
<process type>: <command>
```

## Example Procfile for Python's Flask

Code Capsules only requires a Procfile for python applications. Below is an example of how a Procfile for a Flask application might look like.

```
web: python3 -m flask run --host=0.0.0.0 --port=$PORT
```

## Procfiles for other Languages

Express and Java applications don't need a Procfile to be deployed. The backend capsule can detect these applications and run the processes relevant to the application being deployed. 
