# Comparing Telegram Bot Hosting Providers

AWS
https://levelup.gitconnected.com/simple-telegram-bot-with-python-and-aws-lambda-5eab1066b466 
https://iamondemand.com/blog/building-your-first-serverless-telegram-bot/ 

AWS Lambda allows you to build serverless Telegram bots using a Function-as-a-Service (FaaS) pricing model. This means you only pay for the resources you use excluding idle time. Furthermore, AWS also has a generous free tier that includes 400,000 GB/seconds per month which makes it hard to pay anything if you’re building the bot for fun or as a light application that will only be used by a few people. From a cost perspective, AWS is a reasonable choice but from an ease of use point of view it doesn’t fare well. 

New developers to AWS often find that there’s a learning curve involved in using their services. This is because it generally requires more steps to get an application up and running on AWS as compared to other popular PaaS providers. 

Microsoft Azure
https://docs.microsoft.com/en-us/azure/bot-service/bot-service-channel-connect-telegram?view=azure-bot-service-4.0 
https://www.codeproject.com/Tips/5274291/Building-a-Telegram-Bot-with-Azure-Functions-and-N 

Azure offers two ways to build and host a Telegram bot through Azure functions or the Azure Bot resource, both of which are serverless. The main benefits of a serverless architecture is that it allows the developer to focus only on the code and not worry about deployment issues such as which server to use. If you plan on having a bot on other social platforms using an Azure Bot resource will be advantageous over Azure functions as you can simply add a new channel to the same Bot resource for a new social platform. 

When it comes to pricing, Azure functions beat the Azure Bot resource as the functions are free for the first 12 months of your Azure account creation. The Azure Bot resource uses a pay as you go model which means you only pay for what you use but isn’t free. 

Google App Engine
https://github.com/sooyhwang/Simple-Echo-Telegram-Bot 

App Engine is mostly suited for hosting applications which have different parts working together to achieve one main purpose. As such you can host a Telegram bot on App Engine but you’ll be committing to taking a longer route to getting your bot up and running since the setup process assumes you’re building a more complex app than a bot. 

Apps in App Engine can either run in a standard environment or in a flexible environment. The standard environment has a free tier while the flexible environment doesn’t. Both environments use a pay as you go pricing model. 
Google Cloud Functions
https://seminar.io/2018/09/03/building-serverless-telegram-bot/ 

Cloud Functions were tailor made to run individual services that have a single purpose. This means they are a good choice for event driven solutions such as a Telegram bot using webhooks to only invoke a function after it receives a message from a user. It also has a perpetual free tier which gives customers up to 2 million free invocations per month. If you exceed the 2 million quota you will be charged $0.40 for each million invocations after that. 

On the downside, Google Cloud Functions has a limited feature set when compared to its competitors like AWS Lambda which might be a sticking point if you’re planning on building a serverless function with extensive features.

Google Cloud Run    
https://nullonerror.org/2021/01/08/hosting-telegram-bots-on-google-cloud-run/ 

Cloud Run is a compute platform created to host applications that have high computational needs. It is therefore perfectly capable of hosting a Telegram bot but turns out to be a pricier option beyond the free tier when compared to its sibling, Cloud Functions that can do the same. This is because you’ll be using more demanding resources but shouldn’t be a concern if you aren’t building an enterprise bot since it has a generous free tier. 

Heroku 
https://devcenter.heroku.com/articles/getting-started-with-python
https://github-wiki-see.page/m/python-telegram-bot/python-telegram-bot/wiki/Webhooks#heroku 
https://github.com/Bibo-Joshi/ptb-heroku-skeleton 

Heroku is a PaaS provider for hosting dynamic backend applications. A Telegram bot is a backend application in one form and so can be hosted on Heroku. It is generally easy to use and is well documented which means you shouldn’t struggle to deploy your bot. Heroku uses a more traditional architecture and doesn’t offer serverless functions so developers have to figure out how many servers or dynos as Heroku calls them that their application needs.  

The platform also has a free tier that allows you to host a Telegram bot for free and is fairly priced should you exceed it.  

Code Capsules
https://codecapsules.io/docs/tutorials/create-and-host-telegram-bot/ 

Code Capsules offers different types of capsules or servers to meet your hosting needs from front-end and back-end applications to databases. A Telegram bot can be hosted by a backend capsule with minimal hassle as the platform is relatively easy to use and navigate. The platform only has a free tier for front-end capsules though, meaning you will have to pay to make use of their backend capsules. 
