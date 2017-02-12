# parma

## Installation
### Pre Requisites

* `brew install rethinkdb`
* `brew services start rethinkdb`
* Create a github oauth application and set `GITHUB_CLIENT_ID` & `GITHUB_CLIENT_SECRET`

### Elixir

  ```
  $ brew install elixir
  ```

This will (should) also install Elrang

### Database

  * Create database and run migrations

  ```
    mix ecto.create
    mix ecto.mgirate
  ```

### Hex (Package Manager)

  ```
  $ mix local.hex
  ```

### App

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Use the right version of node by doing `nvm use 6.2.2`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

