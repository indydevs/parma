# parma

## Installation
### Pre Requisites 

* `brew install rethinkdb`
* Create a github oauth application and set `GITHUB_CLIENT_ID` & `GITHUB_CLIENT_SECRET`

### Elixir

  ```
  $ brew install elixir
  ```

This will (should) also install Elrang

### Hex (Package Manager)

  ```
  $ mix local.hex
  ```

### App

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

