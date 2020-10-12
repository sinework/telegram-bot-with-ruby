# telegram-bot-with-ruby(@QuizMeBot)

![screenshot](./images/tel_bot.gif)

## Preface

> This telegram bot can be initialized on the command line(windows) / terminal(mac &amp; linux) where it responds to specific commands - `/start` and `/stop`.

You can find the bot on telegram with the name "@QuizMeBot"

## Purpose

> This is a telegram bot built as a capstone project for Microverse's Ruby module.

- [Preface](#preface)
- [Purpose](#purpose)
- [Features](#features)
- [Presentations](#presentations)
- [Built With](#built-with)
- [Quick Start](#quick-start)
- [Dependencies](#dependencies)
- [Testing](#testing)
- [Author](#author)
- [Acknowledgment](#Acknowledgment)
- [Contributing](#contributing)

## Features

- The bot currently lets a user play a quiz on General knowledge category with different difficult levels.

### Commands To Use

```
start
```

```console
end
```

## Built With

- Ruby 2.6.5
- VS Code
- Telegram Bot API
- REST API from https://opentdb.com/api_config.php recieve the quizes

## Quick Start

### How To Get a Local Copy

- Get a local copy with:

```console
git clone https://github.com/sinework/telegram-bot-with-ruby.git
```

Or download it as a [Zip File](https://codeload.github.com/sinework/telegram-bot-with-ruby/zip/feature).

- Install Ruby in your system. To install Ruby, you can read the [Documentation](https://www.ruby-lang.org/en/documentation/installation/)

- Navigate to your telegram account if you have one. Or create new telegram account.
- Create a new bot with the help of BotFather. Use this documentation if you are facing challenges [New Bot](https://core.telegram.org/bots#6-botfather).
- Obtain your new bot's token.
- Go to the Bot class and assign your token to `TOKEN` variable.

#### Run on terminal/prompt

If you are on windows:

\*- Go inside the project folder

\*- Open prompt here (Option)

```js
ruby bin/main.rb
```

- On your telegram account search for your bot's name

- Then press the /START button begin interacting.

## Dependencies

- rspec
- telegram_bot

## Testing

Install Rspec gem in your system. To do this:

Open Command Prompt or Terminal and run:

```console
gem install Rspec
```

Navigate into the project folder and run the following command in the console:

```console
rspec
```

## Authors

👤 **Sinework Amare Shiferaw**

- Github: [@sinework](https://github.com/sinework)

- LinkedIn: [LinkedIn](https://www.linkedin.com/in/sinework-amare-731a6a125/)

## Acknowledgment

I would like to show my appreciation to https://opentdb.com/api_config.php for the free quiz API they made available for developers

## 🤝 Contributing

Contributions, issues and feature requests are welcome!
Feel free to check the [issues page](https://github.com/JelilFaisalAbudu/tic_tac_toe_game/issues).

## Show your support
