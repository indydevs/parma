# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

import_config "application.exs"

environment_config = Application.get_env(:parma, String.to_atom("#{Mix.env}"))

# General application configuration
config :parma,
  ecto_repos: [Parma.Repo],
  app_name: "parma hook"

# Configures the endpoint
config :parma, Parma.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "z3zIQ5gz8aZD4G1cs04C4p9xy7htc79CKCktyFMAFlTJOhop25HbaYCtuVmzOxqU",
  render_errors: [view: Parma.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Parma.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Guardian
config :guardian, Guardian,
  issuer: "Parma.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Parma.GuardianSerializer,
  secret_key: to_string(Mix.env),
  permissions: %{
    default: [
      :read_profile,
      :write_profile,
      :read_token,
      :revoke_token,
    ],
  }

config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github,  [default_scope: "user,repo,notifications,read:repo_hook,write:repo_hook"] }
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: environment_config.github_client_id,
  client_secret: environment_config.github_client_secret

# Configure your database
config :parma, Parma.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: environment_config.db_user,
  password: environment_config.db_password,
  database: environment_config.db_name,
  hostname: environment_config.db_host

config :toniq, redis_url: "redis://localhost:6379/11"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

