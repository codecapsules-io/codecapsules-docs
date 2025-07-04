---
description: >-
  Learn how to build a Telegram bot that messages you exchange rate data and
  weather forecasts for areas of your choosing.
cover: .gitbook/assets/telegram-bot-cover.jpg
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

# How to Create and Host a Telegram Bot on Code Capsules

_This guide uses Python. You can find the NodeJS version_ [_here_](create-and-host-a-telegram-bot-with-node.js-on-code-capsules.md)_._

In [a previous tutorial](creating-and-hosting-an-api-with-flask/), we created and hosted an API on Code Capsules. In this tutorial, we'll create a client for this API in the form of a Telegram bot. This will allow us to pull temperature, weather and exchange rate data on the go by messaging our bot in the Telegram app.

We'll also learn how to host this bot on [Code Capsules](https://codecapsules.io/) so it can be used by others. Along the way, we'll learn some key concepts about hosting bots securely and efficiently.

Let's get started!

### Requirements

To create a Telegram bot, we'll need:

* [Python](https://www.python.org/) 3.9+ installed.
* A [GitHub account](https://github.com/) and [Git](https://git-scm.com/) installed.
* [Virtualenv](https://pypi.org/project/virtualenv/) installed.
* A [Telegram](https://telegram.org/) account.
* A [Code Capsules](https://codecapsules.io/) account.
* An API on Code Capsules, created using [the Personal API tutorial](creating-and-hosting-an-api-with-flask/).

### About Telegram Bots

Telegram bots appear as contacts on the Telegram interface. Users interact with Telegram bots by messaging them with commands – these are words preceded by a forward slash, e.g. `/weather`, or `/currency`. Commands sent to the bot's account on Telegram will be passed to the bot's backend code (in our case, this will be the code we host on Code Capsules).

For example, when we send the command `/weather` to our bot later in this article, the bot will reply with the weather data from our personal API.

Let's create a Telegram bot.

### Registering a Bot Account and Talking to the BotFather

To create a Telegram bot, we need to download [Telegram](https://telegram.org/) and create a user account. You can use Telegram from either your PC or your phone, or both.

Once you have a Telegram account, you can register a new bot by sending a message to BotFather, a bot managed by Telegram themselves. Search for "BotFather" and initiate a chat. From the chat interface, follow these steps:

1. Press "start".
2. Type `/newbot`.
3. Choose a name for your bot.
4. Choose a username for your bot (must end in "bot").

Once you've chosen a username, the BotFather will reply with an _authorization token_. This is a string that enables your bot to send requests to the Telegram Bot API, similar to the authorisation tokens we used to retrieve weather and exchange rate data in the personal API tutorial. Make sure to save this token somewhere safe and private.

To see if your bot was successfully created, search for the bot's username. You should see the bot and be able to start a conversation with it. Right now, our bot won't reply to anything you send it, as it doesn't have any backend code yet. Let's change that.

### Planning and Setup

We're going to implement two commands for our bot.

* When we send the command `/weather`, our bot will reply with the weather data from the API we created.
* When we send the command `/currency`, our bot will reply with the exchange rates from USD to CAD, EUR, and ZAR.

#### Creating a virtual environment and installing requirements

First, we need to create a local directory. Give it the same name as our bot. Then, from this directory, open a terminal and create a Python [virtual environment](https://docs.python.org/3/tutorial/venv.html) by entering the following command:

```bash
virtualenv env
```

Enter the virtual environment using the appropriate command for your system:

* **Linux/MacOSX**: `source env/bin/activate`
* **Windows**: `env\Scripts\activate.bat`

The virtual environment will help manage our dependencies for when we host the bot on Code Capsules.

To interact with the Telegram Bot API, we need to install the [python-telegram-bot](https://github.com/python-telegram-bot/python-telegram-bot) library, a Python wrapper for the [Telegram Bot API](https://core.telegram.org/bots/api). We'll also use the Python library `requests` to retrieve data from the weather and currency exchange rate API. To install these requirements, enter the following in your terminal:

```bash
pip install python-telegram-bot requests
```

### Retrieving Data from the API

Now we can start coding. Create a file named `bot.py` in the same directory where we activated the virtual environment. In this file, enter the following code, replacing `YOUR-URL-HERE` with the URL pointing to the weather and exchange rate API hosted on Code Capsules.

```python
import requests

url = 'YOUR-URL-HERE/GET'
data = requests.get(url) # requests data from API
data = data.json() # converts return data to json

# Retrieve values from API
curr_temp = data['curr_temp']
cad_rate = data['usd_rates']['CAD']
eur_rate = data['usd_rates']['EUR']
zar_rate = data['usd_rates']['ZAR']


def return_weather():
    print('Hello. The current temperature in Cape Town is: '+str(curr_temp)+" celsius.")


def return_rates():
    print("Hello. Today, USD conversion rates are as follows: USD->CAD = "+str(cad_rate)+
    ", USD->EUR = "+str(eur_rate)+", USD->ZAR = "+str(zar_rate))


return_weather()

return_rates()
```

Here we request the currency and weather data from the API and parse the temperature and conversion rates. Then we print out the data using `return_weather()` and `return_rates()`.

Try it out! Run the program to ensure everything works, then continue.

### Creating the Bot

Now we can get to creating the actual bot. At the top of the `bot.py` file, add this line:

```python
from telegram.ext import Application, CommandHandler
```

From the `python-telegram-bot` library, we import two classes: `Application` and `CommandHandler`. We'll talk about these classes soon.

We don't need to print our data anymore – instead, we'll return a string to our bot, so the bot can display it on Telegram. Replace `def return_weather()` and `def return_rates()` with the following:

```python
def return_weather():
    return 'Hello. The current temperature in Cape Town is: '+str(curr_temp)+" celsius."


def return_rates():
    return "Hello. Today, USD conversion rates are as follows: USD->CAD = "+str(cad_rate)+", USD->EUR = "+str(eur_rate)+", USD->ZAR = "+str(zar_rate)

```

Now, replace the `return_weather()` and `return_rates()` function calls with the code below:

```python
def main():
    TOKEN = "YOUR-BOT-TOKEN-HERE"
    application = Application.builder().token(TOKEN).build()

    weather_handler = CommandHandler("weather", weather)
    currency_handler = CommandHandler("currency", currency)
    start_handler = CommandHandler("start", start)

    application.add_handler(weather_handler)
    application.add_handler(currency_handler)
    application.add_handler(start_handler)

    application.run_polling()

if __name__ == '__main__':
    main()

```

At the top of our new `main` method, which will be called when this file is run, we instantiate `application`, an instance of the Telegram library's [`Application`](https://docs.python-telegram-bot.org/en/stable/telegram.ext.application.html) class. This object will retrieve commands sent to our bot and handle them using the appropriate handlers we define.

Next, we create three different `CommandHandler` classes, one for each command that can be sent to our bot: `/start`, `/weather` and `/currency`. We pass two arguments into each instantiation: the command text (without the preceding `/`), and a function to call. For example, when a user enters the command `/weather`, the `weather()` function will be called.

Let's define that function and the other two. Just above `def main()`, enter the following three function definitions:

```python
async def weather(update, context):
    await context.bot.send_message(chat_id=update.effective_chat.id, text=return_weather())

async def currency(update, context):
    await context.bot.send_message(chat_id=update.effective_chat.id, text=return_rates())

async def start(update, context):
    await context.bot.send_message(chat_id=update.effective_chat.id, text="Hi! I respond to /weather and /currency. Try them!")
```

Each of these functions calls the `python-telegram-bot` function `send_message()` with the ID of the current chat and the appropriate text, either returned from one of our other functions or specified as a string. Note that these functions are now `async` and use `await` when calling bot methods - this is required in the newer version of the library. The `update` and `context` arguments are supplied automatically by the application.

Back in our `main()` function, we use `application.add_handler` to add all three handlers to our application.

Finally, `application.run_polling()` will begin [_polling_](https://en.wikipedia.org/wiki/Polling_\(computer_science\)) for updates from Telegram. This means our code will regularly ask Telegram's servers if any commands have been sent to it. Upon receiving commands, the appropriate handler will be invoked.

The code `bot.py` file should now look like the code below. Once again, make sure to replace `YOUR-URL-HERE` with the URL of the API you created in the API tutorial.

```python
from telegram.ext import Application, CommandHandler
import requests


url = 'YOUR-URL-HERE/get'
data = requests.get(url) # requests data from API
data = data.json() # converts return data to json

# Retrieve values from API
curr_temp = data['curr_temp']
cad_rate = data['usd_rates']['CAD']
eur_rate = data['usd_rates']['EUR']
zar_rate = data['usd_rates']['ZAR']


def return_weather():
    return'Hello. The current temperature in Cape Town is: '+str(curr_temp)+" celsius."

def return_rates():
    return "Hello. Today, USD conversion rates are as follows: USD->CAD = "+str(cad_rate)+ ", USD->EUR = "+str(eur_rate)+", USD->ZAR = "+str(zar_rate)

async def weather(update, context):
    await context.bot.send_message(chat_id=update.effective_chat.id, text=return_weather())

async def currency(update, context):
    await context.bot.send_message(chat_id=update.effective_chat.id, text=return_rates())

async def start(update, context):
    await context.bot.send_message(chat_id=update.effective_chat.id, text='Hi! I respond to /weather and /currency. Try these!')

def main():
    TOKEN = "YOUR-BOT-TOKEN-HERE"
    application = Application.builder().token(TOKEN).build()
    
    weather_handler = CommandHandler('weather', weather)
    currency_handler = CommandHandler('currency',currency)
    start_handler = CommandHandler('start',start)
    
    application.add_handler(weather_handler)
    application.add_handler(currency_handler)
    application.add_handler(start_handler)
    
    application.run_polling()

if __name__ == '__main__':
    main()
```

Below is a conversation with a bot created using this program. Run `bot.py` and try it out yourself.

<figure><img src=".gitbook/assets/CleanShot 2025-06-02 at 15.09.05@2x.png" alt=""><figcaption><p>Telegram Bot Conversation</p></figcaption></figure>

We won't be able to send messages to our bot if this program isn't running, so hosting it on Code Capsules will allow us to interact with the bot without having to keep this code permanently running on our development PC.

While we could deploy our bot to Code Capsules in its current state, there is a downside to our current implementation that we should remedy first.

### Polling versus Webhooks

There are two ways for our `bot.py` file to receive commands sent to it on Telegram. Currently, the code polls Telegram constantly, regardless of whether the bot is in use. If we hosted this current version on Code Capsules, we would be wasting bandwidth, as the vast majority of polls would return nothing.

Instead of polling Telegram for changes, we can create a [_webhook_](https://en.wikipedia.org/wiki/Webhook). This will allow us to receive commands as they are sent by Telegram users, without having to continuously ask Telegram servers for them.

We'll set up a webhook by telling Telegram to send commands sent to our bot account to our bot's Code Capsules URL. Our application will then process the command using the appropriate handler and send back the requested information.

#### Creating a webhook

To set up the webhook, replace the line `application.run_polling()` in the `main` function with the code below:

```python
    PORT = int(os.environ.get('PORT', '443'))
    HOOK_URL = 'YOUR-CODECAPSULES-URL-HERE' + '/' + TOKEN
    application.run_webhook(listen='0.0.0.0', port=PORT, url_path=TOKEN, webhook_url=HOOK_URL)
```

Make sure to add this line to the top of the file:

```python
import os
```

And install Telegram webhooks:

```
pip install "python-telegram-bot[webhooks]"
```

Here we start a webhook that will listen on our Code Capsules URL at TCP port 443 and with the path of our token. Thus, Telegram will relay commands sent to our bot to the following URL:

```
https://YOUR-CODECAPSULES-SUBDOMAIN.codecapsules.io:443/TOKEN
```

If you've completed some of our other backend tutorials, you will be familiar with setting up web servers that receive `GET` and `POST` requests to different routes. You can think of a webhook as a very simple HTTP server that is intended to be used by bots and automated services rather than humans.

### Preparing For Deployment

Before we push our code to GitHub and deploy it on Code Capsules, we need to make one small code change and create some files.

#### Creating an API key environment variable

Because we'll push our code to GitHub, we need to hide our bot's authentication key. If we don't, anyone could use our authentication key and take control of our bot.

Replace this line

```python
TOKEN = "YOUR-BOT-TOKEN-HERE"
```

with the below

```python
import os
TOKEN = os.getenv('BOTAPIKEY')
```

`os.getenv('BOTAPIKEY')` will look for an [environment variable](https://medium.com/chingu/an-introduction-to-environment-variables-and-how-to-use-them-f602f66d15fa) with the name "BOTAPIKEY". When we host our bot on Code Capsules, we'll set this environment variable to the key we received from the BotFather.

With that done, we must now create some files before we can push our code to GitHub and deploy it on Code Capsules.

#### Creating a Procfile and requirements.txt

Code Capsules requires a couple of files to deploy our application: `Procfile` and `requirements.txt`. The first one tells Code Capsules how to run our application, and the second one tells it which libraries it needs to install.

To create the `Procfile`:

1. Navigate to the directory containing the `bot.py` file and enter the virtual environment.
2. Create a file named `Procfile` (with no file extension).
3. Open `Procfile`, enter `web: python3 bot.py`, and save the file.

In the same directory, open a terminal and activate the virtual environment. Then enter `pip3 freeze > requirements.txt` to generate a list of requirements for our Code Capsules server.

Now we can push our code to GitHub. Create a GitHub repository and send the `requirements.txt`, `Procfile`, and `bot.py` files to the repository.

### Deploying the Bot to Code Capsules

With all of the files sent to GitHub, let's deploy the bot to Code Capsules:

1. Log in to Code Capsules and create a Team and Space as necessary.
2. Link Code Capsules to the GitHub repository created previously.
3. Enter your Code Capsules Space.
4. Create a new Capsule, selecting the "Backend" capsule type.
5. Select the GitHub repository containing the bot – leave "Repo subpath" empty and click "Next".
6. Leave the "Run Command" blank and click "Create Capsule".

We haven't supplied our webhook a URL yet, and we still need to create an environment variable for our bot's authorisation token. To create an environment variable:

1. Navigate to your Capsule.
2. Click the "Config" tab.
3. Add an environment variable with the name "BOTAPIKEY" and give it your bot's API key as a value. Make sure to hit the "Update Capsule" button after adding the variable.

<figure><img src=".gitbook/assets/bot-api-key-env.png" alt=""><figcaption><p>Bot API Key Environment Variable</p></figcaption></figure>

Next, let's supply our webhook with the correct domain.

1. Navigate to the "Details" tab.
2. Copy the domain found under "Domains".
3. Open the `bot.py` file and find the line `HOOK_URL = 'YOUR-CODECAPSULES-URL-HERE' + '/' + TOKEN`.
4. Replace "YOUR-CODECAPSULES\_URL" with the domain just copied.
5. Commit and push these changes to GitHub.

After pushing these changes, the Capsule will rebuild. Once this is done, the bot is ready. Give it a try!

### Further Reading

We've covered a lot above, from creating a Telegram bot to the differences between webhooks and polling.

If you're interested in learning more about what you can do with Telegram bots, check out [Telegram's bot developer introduction](https://core.telegram.org/bots). If you have some ideas but require a deeper understanding of the `python-telegram-bot` library, browse their [GitHub repository](https://github.com/python-telegram-bot/python-telegram-bot).

You can find a thorough explanation of webhooks [in this blog post](https://www.chargebee.com/blog/what-are-webhooks-explained/).
