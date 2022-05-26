# 6 Heroku Alternatives
Heroku is an immensely popular platform as a service (PaaS) provider, but naturally it cannot support the use cases of all applications and developers. Issues surrounding endpoint location, pricing, and a [recent security breach] (https://status.heroku.com/incidents/2413), have had developers seeking alternate solutions to this platform. 
## Why use a PaaS
Some advantages in using a PaaS is the infrastructure it provides, like servers and storage as well as services like database management, automatic scaling, and debugging tools. It can save a lot of coding time as the code components needed to run on a platform, such as security features and workflow, are created and managed by the provider. Another advantage of a PaaS is the fact that pay structures often allow for a pay-as-you-go scheme. This enables developers to push their application to production without a large upfront cost.
## How to choose a PaaS
There are many PaaS providers, and this article will function as a guide to choosing and using PaaS for the production of a web service or application.  When choosing between the providers there are a few considerations that may come to mind, like pricing structures, database deliverance, or production workflow. This article will take a look at 5 key points to consider when choosing a provider: pricing (availability of a free tier), production workflow, endpoint location, and app accommodation (front-end vs full-stack). While taking a look at some PaaS services and what they offer in these areas.
This article will explore six alternatives to Heroku: [Code capsules] (https://codecapsules.io/), [Render](https://render.com/), [Fly.io](https://fly.io/), [Google app engine] (https://cloud.google.com/appengine), [AWS Elastic Beanstalk] (https://aws.amazon.com/elasticbeanstalk/), [DigitalOcean App Platform] (https://www.digitalocean.com/), and [Engine Yard] (https://www.engineyard.com/). 

## Code Capsules 

### Pros:
 - Free tier for both static and dynamic web applications
 - Front-end, back-end application hosting with database server support.
 - Deployment from GitHub.
 - Endpoints in Africa and Asia.

[Code Capsules] (https://codecapsules.io/) is a full platform as a service which allows for the deployment of both front-end and back-end applications. There is a free tier for the use of a front-end and back-end capsule. This allows you to test out the deployment of a full-stack web application for free to test out the Code Capsules workflow free of charge. 

Code Capsules advertises ease of use as they allow an application to be pushed to production through a git push command to GitHub. The application is run on a server, called a capsule, which pulls the code from the GitHub repository and builds it within a container created on their website. This means that, once your application is set up in your GitHub repository, all it takes to deploy your code is a git push command. 

Code capsules is one of the few PaaS providers that provides servers in Africa and Asia. This makes it an excellent choice for developers and companies outside of the US or EU. 

Another advantage, for teams working on applications, is the organisational tools Code capsules provides. On the Code Capsules website sections called Teams can be created that allow multiple users to collaborate in a set of Spaces, each of which can contain multiple Capsules (the servers which run the applications). This team and project-based setup provides an organisational structure which is ideal for a collaborative workflow.

## Render
### Pros:
 - Deployment from GitHub.
 - Free tier for static sites, dynamic web services, and database usage.
 - Full-stack support.
### Cons:
 - No endpoints In Africa or Asia.

On the website for  [Render]() there is a page with comparisons against Heroku that you can find [here](). Render provides a simple setup, support for full-stack applications, and a free tier for static sites, web-services and databases. 

The ability to build and update your web service or site through a git push command is a great plus for developer experience. Render offers an easy experience for developers through push to git production as well as auto-suggestions on their dashboard which helps to build and start your application.

These features make Render easy to try out as an app can be deployed easily and with no charge. The pricing structures allow for free deployment of static sites and a limited free deployment for web services. The limitation here being 750 hours of run time per month, for all of your web services. A great feature is that if your web service exceeds this runtime you won’t be charged, but rather the service will stop serving traffic until upgraded or until a new month begins. 

With no endpoints in Africa and Asia Render will not be able to provide the speed necessary for some developers and applications. Their website does say they are looking to extend their endpoints in the future however.

## Fly.io
### Pros
 - Limited Free tier.
 - Postgres database.
 - Simple production workflow.
### Cons
 - Limited free tier.
 - No endpoints in Africa

[Fly.io]() is another PaaS that allows for an easy deployment. Make use of their CLI application to manage and launch your applications through some simple commands. With support for both front-end and full-stack applications this easy to understand production workflow is a big plus. 

Fly.io provides a limited free tier that charges based on a monthly allowance for some resources and a total allowance for others. You can read more about these resource allowances [here](). The allowances can be split across multiple applications. When those resources have been used the account provided will be charged per the resources used. 

Fly.io provides many endpoints to allow for users to have their applications run quickly in the regions where their clients are. No endpoints are found in Africa, however, but notably there are endpoints in Asia and Eastern Europe.

##  Google Cloud App Engine
### Pros:
$300 free quota for new users
Simple deployment workflow
Support for full-stack applications and database usage.
Cons:
 - free tier.
 - No endpoints in Africa.

Google App engine provides a fully managed and serverless platform for web applications and products. With simple commands an app can be deployed in minutes.  Once the code has been set up it can be deployed from a terminal using $ gcloud app deploy. After deployment, Google App Engine will automatically upload code files and run the code within Google’s cloud service Google Cloud. 

While there is no free tier, there is a $300 free quota for new users. You can make use of this quota to test out App Engine and its features before committing to the platform. Being a part of Google Cloud services, App Engine can be utilised with the suite of technologies included in Google Cloud’s Infrastructure as a service. A database, MySQL and PostgreSQL, can be utilised for an extra fee. 

While App engine allows for deployment in a great number of regions, regional deployment for Africa is not supported here.

Follow this [short tutorial] (https://cloud.google.com/appengine/docs/standard/nodejs/create-app) on how to deploy an application to the App Engine. 

## AWS Elastic Beanstalk 
### Pros:
 - Simple deployment workflow
 - Support for full-stack applications and database usage.
### Cons:
 - No free tier.
 - No endpoints in Africa.

Elastic Beanstalk is a PaaS within Amazon Web Services (AWS) that you can utilise to deploy and scale your web applications. To deploy your app through Elastic Beanstalk all it takes is to upload the code from the AWS management console, a command line instruction, a Git repository, or direct from an IDE. 

The Elastic Beanstalk is free to access but charges based on resource usage. Being a part of AWS, Elastic Beanstalk can be utilised with the suite of technologies included in Amazon’s Infrastructure as a service. Your application can connect to an external database or make use of Amazon Relational Database Service (Amazon RDS).

Elastic Beanstalk has a great number of endpoints around the world with the exception of Africa.

Here is a [tutorial] (https://aws.amazon.com/getting-started/guides/deploy-webapp-elb/) on the AWS website that demonstrates how to deploy a web application with Elastic Beanstalk.

## DigitalOcean’s App Platform 

### Pros:
 - Free tier.
 - Deployment from GitHub.
 - Full-stack supported.
 - Databases supported.
### Cons:
 - No endpoints in Africa.

DigitalOcean’s App Platform provides a fully managed PaaS for app deployment. Their free tier allows for the creation of three static sites which is ideal for testing out their workflow and UI before deciding to make use of their services for full app deployment. 

The process of deployment is simple too, with the ability to deploy through a GitHub repository. App Platform also provides deployments with no downtime. This means that changes can be rolled out or applications can be scaled while keeping the application available and operational.

App Platform oversees the management of operating systems, databases, infrastructure, and more. Costs are optimised according to the scaling of your application to ensure that savings are made when the application is not using a lot of resources. App Platform also allows for both vertical and horizontal scaling to ensure that applications can handle spikes in traffic. 

Here you can follow a [tutorial] (https://www.digitalocean.com/community/tutorials/how-to-deploy-a-react-application-to-digitalocean-app-platform) on deploying a simple application. 

Overall, a PaaS should provide an efficient and cost-effective solution to the deployment of an application. Match the suggestions above to a project’s specific use-case to find the best fit for deployment. Consider the scale of the application, the location of its users,  the payment structures, and security requirements to ensure that a PaaS can properly support the production of the application.

