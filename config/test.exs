use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :parma, Parma.Endpoint,
  http: [port: 4001],
  server: false

# Configure your database with Sandbox
config :parma, Parma.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  ownership_timeout: 60_000

# Print only warnings and errors during test
config :logger, level: :warn
