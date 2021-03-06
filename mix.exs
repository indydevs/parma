defmodule Parma.Mixfile do
  use Mix.Project

  def project do
    [app: :parma,
     version: "0.0.1",
     elixir: "~> 1.5",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Parma, []},
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
     {:comeonin, "~> 3.0"},
     {:phoenix, "~> 1.2.1"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.2", override: true},
     {:guardian, "~> 0.14.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:postgrex, "~> 0.13.3"},
     {:tentacat, "~> 0.5"},
     {:ueberauth, "~> 0.4"},
     {:ueberauth_github, "~> 0.4"},
     {:gettext, "~> 0.13"},
     {:cowboy, "~> 1.0"},
     {:exredis, ">= 0.1.1"},
     {:toniq, "~> 1.0"},
     {:poison, "~> 2.0"},
     {:secure_random, "~> 0.5"},
     {:excoveralls, "~> 0.5", only: :test},
     {:ex_machina, "~> 2.1", only: :test},
     {:faker, "~> 0.9", only: :test},
     {:mock, "~> 0.2.0", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
