# Six Heroku Alternatives

Despite its popularity, Heroku can't support the use cases of all applications and developers. Issues surrounding the platform's endpoint location, pricing, and a [recent security breach](https://status.heroku.com/incidents/2413) have had developers seeking alternatives to this platform-as-a-service (PaaS). 

## Why use a PaaS?

The advantages of using a PaaS include the infrastructure (like servers and storage) and services (such as database management, automatic scaling, and debugging tools) it provides. A PaaS can save you a lot of coding time by creating and managing many of the code components you need to run on a platform, such as security features and workflow. And PaaS pay structures often allow for a pay-as-you-go scheme, enabling you to push your application to production without a large upfront cost.

## How to choose a PaaS

We're going to help you find the right PaaS provider for the production of a web service or application by exploring the pros and cons of six alternatives to Heroku:
- [Code Capsules](https://codecapsules.io/)
- [Render](https://render.com/)
- [Fly.io](https://fly.io/)
- [Google app engine](https://cloud.google.com/appengine)
- [AWS Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/)
- [DigitalOcean App Platform](https://www.digitalocean.com/)

When choosing a PaaS, you'll want to consider such things as pricing structure, database delivery, and production workflow. We're going to take a look at PaaS providers in terms of five key points:
1. Free tier availability
2. Production workflow
3. Endpoint location
4. Application accommodation (frontend only versus full stack)

## Code Capsules 

### Pros:
 - Allows both static and dynamic web applications
 - Deployment from GitHub
 - Endpoints in Africa
 - Frontend and backend application hosting with database server support

[Code Capsules](https://codecapsules.io/) is a full platform-as-a-service provider that allows for the deployment of both frontend and backend applications.

Code Capsules allows for an application to be pushed to production through a `git push` command to GitHub. Your application is run on a server, called a Capsule, which pulls the code from your GitHub repository, and builds it in a container created on the Code Capsules website. Once your application is set up in your GitHub repository, all it takes to deploy your code is a `git push` command. 

Code Capsules is one of the few PaaS providers that provides servers in Africa. This makes it an excellent choice for developers and companies outside of the US or EU. 

The organizational tools Code Capsules provides for teams collaborating on applications is another advantage of this service. You can set up Teams of users that share Spaces containing multiple Capsules running applications, an ideal organizational structure for a collaborative workflow.

## Render

### Pros:
 - Free tier for static sites, dynamic web services, and database usage
 - Deployment from GitHub
 - Full-stack support

### Cons:
 - No endpoints in Africa or Asia.

[Render](https://render.com) has a simple set up, support for full-stack applications, and an option for static sites, web services, and databases. You can take a look at [how Render compares to Heroku](https://render.com/render-vs-heroku-comparison) on their website.

With Render, you can build and update your web service or site through a `git push` command – a great plus for developer experience. Additionally, the Render dashboard's auto-suggest helps you build and start your application.

Render's pricing structure allows for the free deployment of static sites and limited free deployment of web services. Render's free tier allows for 750 hours of runtime per month across all your web services, and, if you exceed this allocation, they have a great policy of stopping traffic until you upgrade your account or a new month begins, rather than charging you.

With no endpoints in Africa and Asia, Render will not be able to provide the speed necessary for some developers and applications. Their website does say they are looking to extend their endpoints in the future however.

## Fly.io

### Pros
 - Limited free tier
 - Simple production workflow
 - Postgres database

### Cons
 - Limited free tier
 - No endpoints in Africa

[Fly.io](https://fly.io) is another PaaS that allows for easy deployment. Use their CLI to manage and launch your applications with a few simple commands. Fly.io supports both frontend and full-stack applications, and has an easy-to-understand production workflow. 

Fly.io provides a limited free tier that charges you based on a monthly allowance for some resources and a total allowance for others. You can read more about these resource allowances [on their website](https://fly.io/docs/about/pricing/). You can split allowances across multiple applications, but when your allowance is exceeded, you will be charged for the resources you use. 

Fly.io provides many endpoints so that users' applications run quickly in the regions they are used. There are no Fly.io endpoints in Africa, but there are endpoints in Asia and Eastern Europe.

##  Google App Engine

### Pros:
- A $300 free quota for new users
- Simple deployment workflow
- Support for full-stack applications and database usage

### Cons:
 - No free tier
 - No endpoints in Africa

[Google App Engine](https://cloud.google.com/appengine) provides a fully managed and serverless platform for web applications and products. You can deploy your app with Google App Engine in minutes with simple commands. Once your code has been set up, you can deploy from a terminal using `$ gcloud app deploy`. After deployment, Google App Engine will automatically upload code files and run the code in Google Cloud Platform. 

While there is no free tier, there is a $300 free quota for new users, which you can use to test the platform and its features before committing to it. Google App Engine is a part of Google Cloud Platform, which means you can use it with Google's suite of technologies, including in Google's infrastructure-as-a-service. MySQL and PostgreSQL databases are supported at a fee. 

While Google App Engine allows for deployment in a great number of regions, regional deployment for Africa is not supported.

Follow this [short tutorial](https://cloud.google.com/appengine/docs/standard/nodejs/create-app) on how to deploy an application to Goolge App Engine. 

## AWS Elastic Beanstalk 

### Pros:
 - Simple deployment workflow
 - Support for full-stack applications and database usage
 
### Cons:
 - No free tier
 - No endpoints in Africa

[AWS Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/) is a PaaS within Amazon Web Services (AWS) that you can use to deploy and scale your web applications. You can deploy your app to Elastic Beanstalk with code uploaded from the AWS management console, with a command line instruction, from a Git repository, or directly from an IDE. 

As part of AWS, you can use Elastic Beanstalk with the suite of technologies included in Amazon's infrastructure-as-a-service. Your application can connect to an external database or make use of Amazon Relational Database Service (Amazon RDS).

Elastic Beanstalk is free to access, but you'll be charged based on resource usage.

Elastic Beanstalk has a great number of endpoints around the world, but none in Africa.

Take a look at this [tutorial on how to deploy a web application with Elastic Beanstalk](https://aws.amazon.com/getting-started/guides/deploy-webapp-elb/) from the AWS website.

## DigitalOcean App Platform 

### Pros:
 - Free tier
 - Deployment from GitHub
 - Supports full-stack applications and databases

### Cons:
 - No endpoints in Africa

[DigitalOcean App Platform](https://www.digitalocean.com/products/app-platform) provides a fully managed PaaS for app deployment. Their free tier allows for the creation of three static sites, which is ideal for testing out their workflow and UI before deciding to use their services for full app deployment. 

The process of deployment is simple too, with the ability to deploy through a GitHub repository. DigitalOcean App Platform also provides deployments with no downtime. This means that changes can be rolled out or applications can be scaled while keeping the application available and operational.

App Platform oversees the management of operating systems, databases, infrastructure, and more. Costs are optimised according to the scaling of your application to ensure that savings are made when the application is not using a lot of resources. App Platform also allows for both vertical and horizontal scaling to ensure that applications can handle spikes in traffic. 

Take a look at DigitalOcean's [tutorial on deploying a simple application](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-react-application-to-digitalocean-app-platform). 

## Making the Change

Overall, a PaaS should provide you with an efficient and cost-effective solution for deploying your application. Match the features we've described for these Heroku alternatives to your project’s specific requirements to find the platform that's the best fit for you. Consider the scale of your application, the location of your users, the platform's payment structures, and your security requirements to ensure that a PaaS can properly support the production of your application, and take advantage of PaaS providers' free trial services to test them out before you commit.

