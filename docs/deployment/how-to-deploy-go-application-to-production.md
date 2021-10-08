---
title: Deploy a Go Application
description: A guide to deploying a Go application from GitHub.
---

# How to Deploy a Go Application to Production on Code Capsules

Deploy a Go application that responds with a "Hello World" message when it receives a request. 

## Getting Started

Go is a good choice for writing backends where performance is a priority because of how easily it can be compiled into machine code. 

In this guide, we will take a look at how to deploy a Go application from a Backend Capsule using a [go-demo application]() that can be found on Code Capsules GitHub account. Start by forking the example application mentioned above to your own GitHub account. 

![Go Demo]()

## Linking to GitHub

Now we have to link the forked repository with the Go application to Code Capsules. Sign into your Code Capsules account and navigate to the "Profile" tab. Do this by clicking your profile image at the top right of your screen in Code Capsules. 

![git-button](../assets/deployment/java/git-button.png)

On the "Profile" tab click the "GitHub" button to start the process of linking to the repo. 

Authorise Code Capsules to connect to the Go application repository by:

1. Clicking your GitHub username.
2. Selecting "Only Select Repositories".
3. Choosing the GitHub repository we forked.
4. Pressing "Install & Authorize".

![Install & authorize github](../assets/deployment/python/github-integration.png)

Clicking the "Install & Authorize" button finalizes the linking process and gives Code Capsules access to your repository. 

## Add Repo to Team

After linking Code Capsules to the repository with the Go application, the next step will be to add the repo to your "Personal Team". Doing so allows all Capsules created under that Team to read its data.

Navigate to the "Team Settings" tab and click on the "Modify" button under the _Team Repos_ section to add the repo to your Personal Team. When the "Edit Team Repos" screen slides in, select "Add" next to the repo you linked to in the previous step and confirm your changes. 

![Edit Team Repos](../assets/deployment/python/team-repos.gif)

## Create a Space for Your App

Create a Space to contain the Backend Capsule that will host the Go application we'll deploy shortly. Do this by navigating to the "Spaces" tab and clicking on the "Create A New Space For Your Apps" button.

Actioning this step should trigger the screen shown below to slide in from the right.

![space name](../assets/deployment/python/space-name.png)

Select an appropriate region and enter a name for your space and press "Create Space".

## Create the Capsule

In your recently created Space, create a Backend Capsule by clicking on the "Create a New Capsule for Your Space" button.

Choose a Backend Capsule on the screen that follows, then:

1. Select the "Sandbox" product.
2. Choose the GitHub repository we forked.
3. Press next.
4. Leave the "Run Command" blank and create the Capsule.

![Create Backend Capsule](../assets/deployment/java/creating-backend-capsule.gif)

## View Logs

While the Capsule is building, you can view its build logs under the "Deploy" tab in the Capsule.  

![Build logs](../assets/deployment/python/backend-capsule-build-logs.png)

## View Application

Once built, you can view your application by clicking on the "Live Website" link at the top of your Capsule page.

![Live Website Link](../assets/deployment/mern/live-website-link.png)
