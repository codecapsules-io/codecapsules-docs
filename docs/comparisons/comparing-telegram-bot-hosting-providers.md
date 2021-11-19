# Comparing Telegram Bot Hosting Providers

Bots are perfect for handling repetitive tasks and have been slowly but surely increasing in popularity over the course of the last decade. In this article, we take a look at the different hosting solutions users have when it's time to deploy their Telegram bots. 

## AWS

- [AWS Telegram Bot Tutorial 1](https://levelup.gitconnected.com/simple-telegram-bot-with-python-and-aws-lambda-5eab1066b466)
- [AWS Telegram Bot Tutorial 2](https://iamondemand.com/blog/building-your-first-serverless-telegram-bot/)

AWS Lambda allows you to build serverless Telegram bots using a Function-as-a-Service (FaaS) pricing model. This means you only pay for the resources you use excluding idle time. Furthermore, AWS also has a generous free tier that includes 400,000 GB/seconds per month which makes it hard to pay anything if you’re building the bot for fun or as a light application that will only be used by a few people. From a cost perspective, AWS is a reasonable choice but from an ease of use point of view it doesn’t fare well. 

New developers to AWS often find that there’s a learning curve involved in using their services. This is because it generally requires more steps to get an application up and running on AWS as compared to other popular PaaS providers. 

## Microsoft Azure

- [Azure Telegram Bot Tutorial 1](https://docs.microsoft.com/en-us/azure/bot-service/bot-service-channel-connect-telegram?view=azure-bot-service-4.0)
- [Azure Telegram Bot Tutorial 2](https://www.codeproject.com/Tips/5274291/Building-a-Telegram-Bot-with-Azure-Functions-and-N) 

Azure offers two ways to build and host a Telegram bot through Azure functions or the Azure Bot resource, both of which are serverless. The main benefits of a serverless architecture is that it allows the developer to focus only on the code and not worry about deployment issues such as which server to use. If you plan on having a bot on other social platforms using an Azure Bot resource will be advantageous over Azure functions as you can simply add a new channel to the same Bot resource for a new social platform. 

When it comes to pricing, Azure functions beat the Azure Bot resource as the functions are free for the first 12 months of your Azure account creation. The Azure Bot resource uses a pay as you go model which means you only pay for what you use but isn’t free. 

## Google App Engine

- [Google App Engine Telegram Bot Tutorial](https://github.com/sooyhwang/Simple-Echo-Telegram-Bot) 

App Engine is mostly suited for hosting applications which have different parts working together to achieve one main purpose. As such you can host a Telegram bot on App Engine but you’ll be committing to taking a longer route to getting your bot up and running since the setup process assumes you’re building a more complex app than a bot. 

Apps in App Engine can either run in a standard environment or in a flexible environment. The standard environment has a free tier while the flexible environment doesn’t. Both environments use a pay as you go pricing model. 

## Google Cloud Functions

- [Google Cloud Engine Telegram Bot Tutorial](https://seminar.io/2018/09/03/building-serverless-telegram-bot/) 

Cloud Functions were tailor made to run individual services that have a single purpose. This means they are a good choice for event driven solutions such as a Telegram bot using webhooks to only invoke a function after it receives a message from a user. It also has a perpetual free tier which gives customers up to 2 million free invocations per month. If you exceed the 2 million quota you will be charged $0.40 for each million invocations after that. 

On the downside, Google Cloud Functions has a limited feature set when compared to its competitors like AWS Lambda which might be a sticking point if you’re planning on building a serverless function with extensive features.

## Google Cloud Run    

- [Google Cloud Run Telegram Bot Tutorial](https://nullonerror.org/2021/01/08/hosting-telegram-bots-on-google-cloud-run/) 

Cloud Run is a compute platform created to host applications that have high computational needs. It is therefore perfectly capable of hosting a Telegram bot but turns out to be a pricier option beyond the free tier when compared to its sibling, Cloud Functions that can do the same. This is because you’ll be using more demanding resources but shouldn’t be a concern if you aren’t building an enterprise bot since it has a generous free tier. 

## Heroku 

- [Heroku Telegram Bot Tutorial 1](https://devcenter.heroku.com/articles/getting-started-with-python)
- [Heroku Telegram Bot Tutorial 2](https://github-wiki-see.page/m/python-telegram-bot/python-telegram-bot/wiki/Webhooks#heroku)
- [Heroku Telegram Bot Tutorial 3](https://github.com/Bibo-Joshi/ptb-heroku-skeleton)

Heroku is a PaaS provider for hosting dynamic backend applications. A Telegram bot is a backend application in one form and so can be hosted on Heroku. It is generally easy to use and is well documented which means you shouldn’t struggle to deploy your bot. Heroku uses a more traditional architecture and doesn’t offer serverless functions so developers have to figure out how many servers or dynos as Heroku calls them that their application needs.  

The platform also has a free tier that allows you to host a Telegram bot for free and is fairly priced should you exceed it.  

## Code Capsules

- [Code Capsules Telegram Bot Tutorial](https://codecapsules.io/docs/tutorials/create-and-host-telegram-bot/) 

Code Capsules offers different types of capsules or servers to meet your hosting needs from frontend and backend applications to databases. A Telegram bot can be hosted by a backend capsule with minimal hassle as the platform is relatively easy to use and navigate. The platform only has a free tier for front-end capsules though, meaning you will have to pay to make use of their backend capsules. 

Code Capsules also supports a wide variety of languages ensuring you have plenty of options to choose from when deciding the tech stack for your bot.

## Red Hat OpenShift

- [OpenShift Telegram Bot Tutorial 1](https://github.com/lufte/python-telegram-bot-openshift)
- [OpenShift Telegram Bot Tutorial 2](https://github.com/gotham13/python-telegram-bot-openshift3) 

Red Hat OpenShift is an enterprise Kubernetes platform that’s built for an open hybrid cloud strategy. Using OpenShift to host a Telegram bot might be considered as overkill since the platform was built for far more demanding enterprise use cases. There’s also a learning curve involved when setting up your first OpenShift container which you’ll need to deploy your Telegram bot. 

OpenShift does have a free trial but the process of buying it officially has a lot of steps and sometimes sales agents are involved depending on the plan you will be buying.  

## PythonAnywhere

- [PythonAnywhere Telegram Bot Tutorial](https://blog.pythonanywhere.com/148/)

PythonAnywhere is an online IDE and PaaS for hosting projects you’d have written in the browser. This makes it convenient and easy to use especially for beginners who might find any project setup stage daunting. The experience is synonymous to that of other popular serverless functions providers as the developer only has to worry about writing their code. You can host a Telegram bot with them but the major restriction in choosing PythonAnywhere is the programming language. As the name suggests, you can only develop and host Python projects with them which isn’t ideal since they leave out other popular languages like Node.js, Java and C#. 

They have a basic plan which is free but doesn’t support applications at scale. For applications that need scaling, they have a Hacker account which costs $5/month and can support apps that get up to 10,000 hits/day. 

## Oracle Cloud

Oracle Cloud is a cloud compute platform offering IaaS and PaaS products to its customers. It is more than capable of hosting a Telegram bot using its functions service in the PaaS branch. However, new developers to the platform might find it hard to navigate as their site is flooded with the many different kinds of services they offer. Beyond that, it is a reputable platform with a 30 day free trial to allow you to test drive the service you’d have signed up for. After the free trial ends, you’ll be billed for the resources you use on a pay as you go model.   

## Vercel

- [Vercel Telegram Bot Tutorial 1](https://www.marclittlemore.com/serverless-telegram-chatbot-vercel/)
- [Vercel Telegram Bot Tutorial 2](https://dev.to/jj/create-a-serverless-telegram-bot-using-go-and-vercel-4fdb) 

Vercel is a PaaS provider primarily for hosting frontend and static sites but their serverless functions offering makes it possible to deploy a Telegram bot to their platform. The serverless functions support Node.js, Go, Python and Ruby so you have plenty of options to choose from when it comes to deciding which language to write your bot in. Vercel is also a relatively easy to use platform meaning that even new developers shouldn’t struggle to host their first project with them. 

The platform has a free plan which unfortunately doesn’t support functions. The package that supports functions starts at $20/team member/month and has a 14 day free trial period.  

## Joyent Triton

Joyent is a cloud compute platform offering an array of services from IaaS to PaaS. Users can host a Telegram bot on Joyent through their Node.js Support service which as they claim is uniquely equipped to deliver the highest level of support for powerful enterprise applications. The platform is mainly geared towards enterprise customers so if you just want to host a Telegram bot to showcase to friends and family this provider might be overkill. 

## Conclusion

There are many providers capable of hosting a Telegram bot but the choice as to which one is right for you will mainly depend on the tech stack you plan to use and the size of your budget. If evaluating which provider to use from an ease of use perspective and how quickly you can get your bot up and running then Code Capsules and PythonAnywhere come out on top with the latter having the disadvantage of it only being able to host Python projects. 

Code Capsules supports most of the popular modern languages of today including but not limited to Python, Node.js and Go but has the disadvantage that it doesn't have a free tier for backend capsules which you'll need to host a Telegram bot.
