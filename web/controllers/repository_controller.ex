defmodule Parma.RepositoryController do
    use Parma.ApplicationController, :controller

    plug EnsureAuthenticated, handler: __MODULE__
    plug :set_current_user

    def index(conn, _params, current_user, _claims) do
      user_repositories =
        current_user
        |> Parma.Repo.preload(:repositories)
        |> Map.get(:repositories)

      render conn, "index.html", user_repositories: user_repositories
    end
  end
