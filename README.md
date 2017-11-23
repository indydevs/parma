![parma logo](https://cldup.com/8ULBQyooFe.png)

[![Build Status](https://travis-ci.org/indydevs/parma.svg?branch=master)](https://travis-ci.org/indydevs/parma)
[![Coverage Status](https://coveralls.io/repos/github/indydevs/parma/badge.svg)](https://coveralls.io/github/indydevs/parma)

## Installation

### Elixir

At the time of writing, Elixir 1.5.0 was the latest. Unfortunately, homebrew only has the latest version of
Elixir. If the latest is not `1.5.0` then please [install Elixir from source](https://elixir-lang.org/install.html#compiling-from-source-unix-and-mingw)

```
$ brew install elixir
```

This should also install erlang OTP for you.

### Database

```
$ brew install postgresql
```

*brew should also star the postgre service automaticaly*

### Hex (Package Manager)

```
$ mix local.hex
```

### App

* Copy the application sample file `cp config/application.exs.sample application.exs`
* Configure your database credentials in `config/application.exs`
* Install dependencies with `mix deps.get`
* Create, migrate and seed your database with `mix ecto.setup`
* Install Node.js dependencies with `npm install`
* Use the right version of node by doing `nvm use 6.2.2`

### Github Setup

* [Create a github oauth application](https://github.com/settings/applications/new)
* Use `http://localhost:4000/` as your **Authorization callback URL**
* Once done, copy the `client_id` and `client_secret` and paste it in `config/application.exs`

### Start Server
Start Phoenix endpoint with `mix phoenix.server`

If you want to run in debug mode, start the server with `iex -S mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

