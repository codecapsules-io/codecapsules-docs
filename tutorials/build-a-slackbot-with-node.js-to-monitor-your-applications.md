---
description: >-
  Create a bot that monitors the state of your applications and reports any
  status changes via Slack.
cover: .gitbook/assets/CodeCapsules_SlackBot.jpg
coverY: 0
layout:
  cover:
    visible: true
    size: hero
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# Build a Slackbot with Node.js to Monitor your Applications

Slack is a really useful communication tool when working in teams. Many developers find themselves using it almost constantly when working on projects.

One of the standout features of Slack is the rich API it exposes, to allow developers to integrate with it.

In this tutorial, we'll use the Slack API to give our apps a voice. We'll be able to talk to our apps running on Code Capsules, to ask about their status and see if they are up and running. They will also be able to alert us when they boot up, so we know if they have been successfully deployed or restarted.

### Overview and Requirements

As we're building a Slackbot, you'll need to sign up for an account on [Slack](https://slack.com) if you haven't already got one. Ideally, for this tutorial, you should use a Slack workspace that you can safely send many test messages to while we are creating this bot, without disturbing people.

We'll also need the following:

* [Git](https://git-scm.com/downloads) set up and installed, and a registered [GitHub](https://github.com/join) account.
* [Node.js](https://nodejs.org/en/download/) installed.
* A registered [Code Capsules](https://codecapsules.io/) account.
* An IDE or text editor to create the project in. This tutorial was made using [Visual Studio Code](https://code.visualstudio.com/), but feel free to use any tool you like.

### Setting Up the Project

With our requirements in place, we can get started on setting them up to work as needed for our Slackbot project.

#### Create a new repo on GitHub

We need a place to store our code from which Code Capsules can deploy to a capsule. A repository on GitHub is just what we need.

Head over to GitHub and create a new repo. We're calling it _slackbot_ here, but you can call it whatever you like.

Note: You can also add this code to an existing backend project if you would like to monitor it; perhaps something you built in an earlier tutorial.

#### Initialise the base project

Now we can get some base code set up. Let's start by cloning the new GitHub repo onto our local computer.

Now, go into the directory of the repo you've just cloned.

We can initialise a new Node.js project by typing the following at the terminal (or command prompt, if you're on Windows):

```bash
npm init
```

We can just press **Enter** for each of the questions it asks; the defaults are good to start with.

#### Install our packages

Now that we have our project initialised, we can add the packages we need to create our bot. These are:

* [Express](https://expressjs.com): This acts as our web server and HTTP request router. We'll use this to route requests from Slack to the correct logic.
* [body-parser](https://www.npmjs.com/package/body-parser): This interprets and parses payload data from HTTP requests. We'll need this to parse the URL-encoded data Slack sends to us with a request.
* [superagent](https://www.npmjs.com/package/superagent): This package allows us to make outgoing HTTP requests. We'll need this to send a message to Slack.

Let's type in the following at the terminal to install the packages:

```bash
npm install express body-parser superagent 
```

Now let's create an `index.js` file, which will be the main file for our app. A simple way to do this is to open up your project folder in an editor, like [Visual Studio Code](https://code.visualstudio.com). Now you can create a new `index.js` file.

<figure><img src=".gitbook/assets/create-indexjs.gif" alt=""><figcaption><p>Create Index.js in Visual Studio</p></figcaption></figure>

Save this blank file.

Great, it's time to push this boilerplate project up to Git. We can do it from the terminal with the following:

```bash
git add . 
git commit -am 'added base files for project'
git push origin
```

#### Create a new Code Capsule

We'll need a place to host our app.

1. Log in to [Code Capsules](https://codecapsules.io), and create a Team and Space as necessary.
2. Create a "Backend Capsule", your Team and Space.
3. Choose your payment plan.
4. Click the GitHub button and give access to the repository you forked at the start of the tutorial.
5. Choose the GitHub repository you forked.
6. Press "Next".
7. Leave "Run Command" blank.
8. Click "Create Capsule".

#### Register an app on Slack

After you've created a workspace on Slack or logged into an existing one, head over to [https://api.slack.com](https://api.slack.com) and click on "Create a custom app".

On the dialog that comes up, we can give our app a name and choose which workspace we want to add it to. You can choose any name you wish – we've used _Serverbot_ here. Now we can click "Create App".

Great! We've created our app. Now we can configure it.

For this tutorial, we would like the following two functions:

1. Our Code Capsules app should automatically send us a notification whenever it starts up. This allows us to easily know when a new deployment is successful. It can also alert us to any potential crashes and restarts.
2. We want to query our Code Capsules app from Slack at any time to see how it's doing.

Our first requirement can be configured on the Slack side by clicking "OAuth & Permissions" on the left panel. Scroll down to the _Scopes_ section, click "Add an OAuth Scope" under the _Bot Token Scopes_ section, and choose "Chat:Write" from the options list. This now allows our bot to initiate and post messages to us when it starts up.

<figure><img src=".gitbook/assets/slack-scopes (1).png" alt=""><figcaption><p>Select Scopes Slack</p></figcaption></figure>

Our second requirement can be configured by setting up a _slash command_. Click on the "Slash Commands" menu item on the left, under _Features_.

<figure><img src=".gitbook/assets/choose-slash-command (1).png" alt=""><figcaption><p>Slash Command Menu</p></figcaption></figure>

Then click "Create a new Command". We'll give the command the name _/stats_. For the _Request URL_, copy the _Domain_ name from your Code Capsules Overview page.

<figure><img src=".gitbook/assets/backend-url.png" alt=""><figcaption></figcaption></figure>

Paste your domain into the _Request URL_ box on Slack, and add `/slack/command/stats` to the end of it. We can fill in a description as well, something like 'Returns key stats from the app'.

<figure><img src=".gitbook/assets/create-command (1).png" alt=""><figcaption></figcaption></figure>

Great, now we can click "Save" at the bottom of the page to finish setting up our slash command.

### Writing the Slackbot Code

Now that we have all our systems set up, we can get onto the coding part.

#### Adding the base code

Let's add the boilerplate code to start a new Express server. Open up the `index.js` file and add the following:

```javascript
const express = require('express'); 

const app = express();

let port = process.env.PORT || 3000;
app.listen(port, ()=>{
  console.log(`App listening on port ${port}`);
});
```

#### Sending a startup message to Slack

Ok, cool, we've got the base code to create an Express app, and start it up to begin listening for requests. Now we can add some code to send a message to Slack when it boots up, not just locally to the console. If we look at the [docs on Slack](https://api.slack.com/messaging/sending), we see that we can POST to the endpoint `https://slack.com/api/chat.postMessage` to send a message. In their example, they specify that we need:

1. An access token.
2. The channel ID of the channel to post the message to.
3. The message we want to post as the requirements.

To get the access token, head over to your app dashboard on Slack and click on the "OAuth & Permissions" menu item on the left-hand side. Then click the "Install to Workspace" button, and then the "Allow" button. After this, you should see a newly generated "Bot User OAuth Token". Copy this token – this is our access token.

We could just put this token in our code. However, this is not really considered best practice for sensitive secrets and credentials. Rather, let's add this secret as an **Environment Variable**, and access it from the Node.js [process object, on the `.env` property](https://nodejs.org/api/process.html#process_process_env).

To add the access token to the environment in Code Capsules, head over to the capsule we created earlier and click on the "Config" tab. Now we can fill in our environment variable for the access token. Add a new environment variable with the name `SLACK_BOT_TOKEN` and set the value to the token copied from Slack.

<figure><img src=".gitbook/assets/slack-bot-token.png" alt=""><figcaption></figcaption></figure>

Now that we've added our access token, we need to find the ID of the channel we want to post to. Find a channel on your Slack workspace that you want to send to, or create a new channel. Now we can get the channel ID by right-clicking on the channel name to bring up a context menu. Now, we can choose "Copy Link" from that menu:

<figure><img src=".gitbook/assets/copy-channel-link (1).png" alt=""><figcaption></figcaption></figure>

If we paste that link, we get something like `https://<workspace-name>.slack.com/archives/C01SZ6Z3TCY`. The last part of that URL is the channel ID; in this example case, `C01SZ6Z3TCY`.

Let's add this to our environment variables as well, as it keeps all the configurations in one place. Head back over to your Capsule, and add in an environment variable with the name `SLACK_CHANNEL_ID` and set the value to the channel ID we extracted above. Click the "Update & Start Build" button to save the changes to the environment variables.

<figure><img src=".gitbook/assets/slack-channel-id.png" alt=""><figcaption></figcaption></figure>

We also need to invite our bot to the chosen channel, so that it will be able to post there. Go to the channel, and @ mention the name you gave the bot to add it. Click "Invite Them" when Slack prompts you.

<figure><img src=".gitbook/assets/invite-bot (1).png" alt=""><figcaption></figcaption></figure>

Now let's add the code to call Slack on startup, and write a message to our channel. We can modify our boilerplate code above to make an HTTP POST to the endpoint `https://slack.com/api/chat.postMessage`. We'll use [Superagent](https://www.npmjs.com/package/superagent) to make the call.

```javascript
const express = require('express');
const superagent = require('superagent');

const app = express();

let port = process.env.PORT || 3000;
app.listen(port, ()=>{
  console.log(`App listening on port ${port}`);
  sendStartupMessageToSlack(); 
});

function sendStartupMessageToSlack(){
    superagent
      .post('https://slack.com/api/chat.postMessage')
      .send({
        channel:process.env.SLACK_CHANNEL_ID, 
        text:"I'm alive and running"
      })
      .set('accept', 'json')
      .set('Authorization', 'Bearer '+ process.env.SLACK_BOT_TOKEN)
      .end((err, result) => {
      });
}
```

We've added a function `sendStartupMessageToSlack` which makes the call out to Slack. Notice that we send the auth token in a header, using `.set('Authorization', 'Bearer '+ process.env.SLACK_BOT_TOKEN)`. The `Authorization` header is a standard HTTP header.

The channel and the message are sent in the body. Feel free to modify the startup message from _I'm alive and running_ to whatever you'd like.

#### Deploying to Code Capsules

This seems like a great time to test out our app on Code Capsules. But before we do that, there is one thing we have to do to make it work. We need to tell Code Capsules how to run our app. By default, Code Capsules will call `npm start` after deploying the code. Therefore, we just need to add a `start` script to our `package.json` file in order for our code to be run on Code Capsules.

Open the `package.json` file. Under the `scripts` section, add the line `"start": "node index.js"`. The `package.json` file should look like this now:

```json
{
  "name": "slackbot",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "node index.js"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "body-parser": "^1.19.0",
    "express": "^4.17.1",
    "superagent": "^6.1.0"
  }
}
```

Ok, let's save all the files we've created, add and commit, and then push to our repo. When Code Capsules sees that there is a new commit, it will automatically deploy our code.

```bash
git add . 
git commit -am 'added code to call Slack on startup'
git push origin
```

If all goes well, in a few minutes you should get a message on your Slack channel from your code!

<figure><img src=".gitbook/assets/startup-message.png" alt=""><figcaption></figcaption></figure>

#### Adding a slash command

Now that our app can send us messages, can we send messages back to it? Let's implement the slash command, which will allow us to ask our app for some of its important stats and info. This time, Slack will send an HTTP POST to our app. If we take a look at the [Slack docs again](https://api.slack.com/interactivity/slash-commands#app_command_handling), we notice that Slack will send the slash command instruction to the URL we specified in the command setup earlier. We can also see that the POST payload is in the format [`application/x-www-form-urlencoded`](https://www.w3schools.com/html/html_urlencode.asp). We can set up a [`body-parser`](https://github.com/expressjs/body-parser/tree/1.19.0#bodyparserurlencodedoptions) to interpret this data.

Let's extend our code with the snippet below to implement the slash command receiver as specified in the Slack docs. First, add a require statement for `body-parser` at the top.

```javascript
const bodyParser = require("body-parser");
```

Then add the code below:

```javascript
app.use(bodyParser.urlencoded());

app.post('/slack/command/stats', [function(req,res){
  const slackReqObj = req.body;
  const packageJson = require('./package.json');

  const current_time = new Date(); 
  const stats = {
    name: packageJson.name,
    version: packageJson.version,
    environment: process.env.NODE_ENV,
    platform: process.platform,
    architecture: process.arch,
    node_version: process.version,
    pid: process.pid,
    current_server_time: current_time.toString(),
    uptime: process.uptime(),
    memory_usage: process.memoryUsage()
  };

  const response = {
    response_type: 'in_channel',
    channel: slackReqObj.channel_id,
    text: JSON.stringify(stats, null, '\t')
  };

  return res.json(response); 
}]);

```

This code listens for incoming POST calls on the line `app.post('/slack/command/stats', [function(req,res){`. If we receive one, we build up a return object, consisting of various interesting stats and info. This includes the current time on the server (in case it is in a different time zone to us), the name and version of our app as set in the `package.json` file, and various environment and process info.

Then it replies to the request in the format specified by Slack in their docs. We use the line `text: JSON.stringify(stats, null, '\t')` to turn our info and stats object into a nicely formatted text string, in the style of a JSON object.

Then, in the line `return res.json(response);`, we return all the info back to Slack to display as the response to a matching slash command.

Great, now we can commit and push this code.

```bash
git commit -am 'added handler for slash command'
git push origin 
```

After the code has finished deploying on Code Capsules (it should send a startup message again when it's ready), we can test the slash command.

Type `/stats` in the channel we chose earlier. After a second or two, the app should respond with its current vital stats and information.

<figure><img src=".gitbook/assets/slash-command-test.png" alt=""><figcaption></figcaption></figure>

#### Adding verification

We can ask our app via Slack (which we use constantly!) how it's doing; pretty cool, huh? There is a problem, though. If we call our slash command endpoint from anywhere else, for instance, if we just call it using [Postman](https://www.postman.com), it also returns all the information and stats! This would not be good for a production system, as sensitive information will be easily found by attackers.

<figure><img src=".gitbook/assets/postman-slash-command.png" alt=""><figcaption></figcaption></figure>

So, how can we ensure that the request comes from our Slack workspace? Luckily, Slack has thought about this and sends a [message signature with its requests](https://api.slack.com/authentication/verifying-requests-from-slack). From the [guide in Slack's docs](https://api.slack.com/authentication/verifying-requests-from-slack#verifying-requests-from-slack-using-signing-secrets__a-recipe-for-security__step-by-step-walk-through-for-validating-a-request), we can put together some code to check that the request is legitimately from Slack. The main parts of the check, copied from the docs, look like this:

> * Retrieve the X-Slack-Request-Timestamp header on the HTTP request, and the body of the request.
> * Concatenate the version number, the timestamp, and the body of the request to form a basestring. Use a colon as the delimiter between the three elements. For example, v0:123456789:command=/weather\&text=94070. The version number right now is always v0.
> * With the help of HMAC SHA256 implemented in your favorite programming language, hash the above basestring, using the Slack Signing Secret as the key.
> * Compare this computed signature to the X-Slack-Signature header on the request.

We can also check the timestamp to ensure that it is not a [replay attack](https://en.wikipedia.org/wiki/Replay_attack) of a message from long ago.

Ok, let's implement this in our project. First, we somehow need to access the raw body of the request, before it has been parsed by `body-parser`. This is to ensure that the signing hash we calculate is using the same data that Slack did. After parsing, there could be extra characters and formatting etc. Luckily, the [body parser package has a verify option](https://github.com/expressjs/body-parser#verify-3), which passes a binary buffer of the raw body request to a user defined function. Let's make a function that conforms to the specs given by `body-parser`. Add this code to your `index.js` file:

```javascript
var rawBodySaver = function (req, res, buf, encoding) {
  if (buf && buf.length) {
    req.rawBody = buf.toString(encoding || 'utf8');
  }
}
```

In this function, we grab the bit stream buffer `buf`, and check that it is not null and that it is not empty (by checking that it has a length). Then we tack it onto the request `req` as a new property `rawBody`. We also convert the buffer to a string, using the encoding supplied, or fall back to `utf8` as a default. Now that the `rawBody` is added to the request, it will be available for use by subsequent middleware. We can add it to the body parser by modifying the code where we add the body parser to the app.

```javascript
app.use(bodyParser.urlencoded({ verify: rawBodySaver}));
```

In the code above, we added options to our body parser initialization. We set the `verify` option to the method we added above.

Now, let's make a new [middleware function](http://expressjs.com/en/guide/writing-middleware.html) to calculate the signature and compare it. We'll be able to call this middleware before our current code for responding to our Slack slash command. Making it a middleware function will also allow us to easily re-use it on other routes, if we want to add more slash commands, or other commands from Slack in the future. We'll make a new file to hold this code. We'll call it `signing.js`.

In the new file, let's add this code:

```javascript
const crypto = require('crypto');

function checkSlackMessageSignature(req, res, next){
    const timestamp = req.headers['x-slack-request-timestamp']; 
    const fiveMinutesAgo = Math.floor(Date.now() / 1000) - (60 * 5);

    if (timestamp < fiveMinutesAgo) {
        return res.sendFail(401, "mismatched timestamp");
    }

    const signing_secret = process.env.SLACK_SIGNING_SECRET; 
   
    const slack_signature = req.headers['x-slack-signature']; 
    const [version, slack_hash] = slack_signature.split('=');

    const sig_basestring = version + ':' + timestamp + ':' + req.rawBody;
    const hmac = crypto.createHmac('sha256', signing_secret); 
    hmac.update(sig_basestring); 
    const our_hash = hmac.digest('hex');    

    if (crypto.timingSafeEqual(Buffer.from(slack_hash), Buffer.from(our_hash))) {
        return next(); 
    }
    else {
        return res.send(401, "Invalid request signature");
    }
}

module.exports = checkSlackMessageSignature; 

```

Let's take a look at this code. Firstly, we import the [crypto (cryptography) library](https://nodejs.org/api/crypto.html#crypto_crypto). We don't need to install this as a package, as it is built into Node.js. This library will allow us to perform the [hash](https://en.wikipedia.org/wiki/Secure_Hash_Algorithms) of the basestring to compare with the signature.

Next, we create a function with the [standard Express middleware parameters](http://expressjs.com/en/guide/writing-middleware.html):

* `req`, representing the request data.
* `res`, representing an output object which we return results to the user.
* `next`, representing a function to call if we want to hand control to the next middleware function in the chain. It can also be used to pass an error object back up if something goes wrong processing the request.

Then, on the first few lines of the function, we get the timestamp Slack sends from the request headers, and check that it is within the last few minutes. Note the name of the header is all in lowercase, even though Slack specifies that the header is capitalised. This is because Express converts all header keys to lowercase when serving a request.

After that, we retrieve the Slack Signing Secret from our environment variables. Let's get our Signing Secret from Slack and add it to the Code Capsules environment now. Head over to your Slack app dashboard, and click on "Basic Information" in the left-hand sidebar. Then scroll down to _App Credentials_, and look for the _Signing Secret_. Click "Show", and copy the secret.

<figure><img src=".gitbook/assets/slack-signing-secret (2).png" alt=""><figcaption></figcaption></figure>

Now, head over to your Capsule on Code Capsules and click on the _Config_ tab. Add a new environment variable with _Name_ `SLACK_SIGNING_SECRET` and paste in the value of the _Signing Secret_ we copied above. Click "Update & Start Build" to save the changes.



<figure><img src=".gitbook/assets/slack-signing-secret (1).png" alt=""><figcaption></figcaption></figure>

Ok, back to the function. After we retrieve the signing secret from the environment variables, we read out the hash calculated and sent by Slack from the headers using `const slack_signature = req.headers['x-slack-signature']`. This will be a string that looks something like `v0=xxxxxxxxxxxxxxxxxxxxxxx`, where the `xxxx` represents the actual hash value. We need to split the version identifier `v0` from the beginning of the string, though, as this is not part of the hash value. We do this in the next line, `const [version, slack_hash] = slack_signature.split('=')`. Now we have both the version and the hash string in variables that we can access.

After this, we construct our basestring, made from the version we extracted above, the timestamp of the request, and the `rawBody` (which we extracted in our body parser `verify` function earlier).

The next two lines are where we actually calculate the hash. First, we set up the `crypto` module with our crypto algorithm type [`SHA256`](https://en.wikipedia.org/wiki/SHA-2), and with our unique Signing Secret. This allows us to then create an [HMAC – or Hash Based Message Authentication code](https://en.wikipedia.org/wiki/HMAC), which is the fancy name for the message signature. We then use the `update` method on our newly created HMAC to load in our basestring that we constructed above.

Now that the crypto HMAC is primed with all the info it needs, we can call the `digest` function to actually calculate the hash. We pass in as a parameter `hex` to indicate that we want the result back in [hexadecimal format](https://en.wikipedia.org/wiki/Hexadecimal), as this is the same format that Slack sends their calculated hash value in.

Great, so now we have Slack's signature hash and our hash. We need to check that they are the same, which will prove that the message was legitimately sent by Slack. We could just use a normal string compare, i.e. `if (slack_hash === our_hash)`, but there is a slight security issue with this, known as a [timing attack](https://codahale.com/a-lesson-in-timing-attacks/). This type of attack is based on the knowledge that a normal string comparison function takes a different amount of time to compare two strings, depending on how close the strings are to each other. An attacker can take advantage of this timing difference to repeatedly send messages and, based on the time for our server to respond, can guess at how close their hash is to what we are expecting. With much patience and many thousands of messages, an attacker could eventually guess our Signing Secret, compromising all our checks.

comparisonLuckily, there is a simple way to protect from this, and it's built right into the `crypto` library. This is where we call `crypto.timingSafeEqual`. This comparison always returns in the same amount of time, regardless of how close the hashes are to each other. Therefore, we don't give any extra information away to would-be attackers.

Now, if the hashes are equal, from our `timingSafeEqual` test, we just call `return next()` which exits our function and passes control to the next middleware function (which will be our slash command handler).

If the hashes are not equal, then we know this request is not genuinely from Slack, so we can end early and send a `401`, which is a [standard HTTP code](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#4xx_client_errors) for `Unauthorized`. Basically, we boot the imposter out.

Now, the last line in this file is `module.exports = checkSlackMessageSignature`. This allows our middleware function to be visible to other modules that import this file.

Ok, now that we've got this middleware created, let's link it to our slash command handler. Head on back to the `index.js` file, and import the middleware function by adding this line near the top of the file:

```javascript
const checkSlackMessageSignature = require('./signing'); 
```

Now, we can navigate to our Slack command handler, which started like this: `app.post('/slack/command/stats'`. Modify that to include a call to the message signature check before the actual handler, like this:

```javascript
app.post('/slack/command/stats', [checkSlackMessageSignature, function(req,res){
```

Fantastic, now our app is secure. You can commit all the changes and push them up to Git, which will kick off our final deploy to Code Capsules:

```bash
git add . 
git commit -am 'added message signature checking'
git push origin
```

Once the code is up and running on Code Capsules, test it out to see that it still responds to the Slack slash command. Then you can try again from Postman or other similar apps, and see that it will not send any info without a valid signature (you can use `v0=a2114d57b48eac39b9ad189dd8316235a7b4a8d21a10bd27519666489c69b503` as an example `x-slack-signature` parameter):

<figure><img src=".gitbook/assets/401-auth.png" alt=""><figcaption></figcaption></figure>

### Things to Try Next

What else can we do? It's almost endless!

* Add this code to an existing app you have built to get easy info straight from Slack!
* Add in more slash commands for more info – for example, you could get the current user count on your app, a number of database records, etc. Basically, any information you could need for [DevOps](https://en.wikipedia.org/wiki/DevOps).
* Look at some of the other functionality Slack offers for integration; for example, using [modals](https://api.slack.com/surfaces/modals) or listening in for [keywords in messages](https://api.slack.com/messaging/managing).
