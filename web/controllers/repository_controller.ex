defmodule Parma.RepositoryController do
    use Parma.ApplicationController, :controller

    alias Parma.RepositoryService

    plug EnsureAuthenticated, handler: __MODULE__
    plug :set_current_user

    def index(conn, _params, current_user, _claims) do
      user_repositories =
        current_user
        |> Repo.preload(:repositories)
        |> Map.get(:repositories)

      render conn, "index.html", user_repositories: user_repositories
    end

    def update(conn, params, current_user, _claims) do
      repository =
        Parma.Repository
        |> Repo.get(params |> Map.get("id"))

      case repository do
        nil -> render_error(conn, 404)
        record ->
          {status, _message} =
            case params |> Map.get("enable") |> String.to_existing_atom do
              true -> RepositoryService.enable(repository, current_user)
              false -> RepositoryService.disable(repository, current_user)
            end

          template =
            case status do
              :ok -> render conn, "update_success.json"
              :not_found -> render_error(conn, 404)
              _ -> render_error(conn, 500)
            end
      end
    end

    def render_error(conn, status) do
      conn
      |> put_status(status)
      |> render Parma.ErrorView, "#{status}.json"
    end
  end
