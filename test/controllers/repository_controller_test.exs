defmodule Parma.RepositoryControllerTest do
    use Parma.ConnCase
    use Parma.AuthHelper
    import Parma.Factory

    test "#index gives a list of user repositories", %{conn: conn} do
        user_with_repo = user_with_repositories()

        response =
          conn
          |> guardian_login(user_with_repo)
          |> get(repository_path(conn, :index))

        for repository <- user_with_repo.repositories do
          assert html_response(response, 200) =~ repository.name
        end
    end
  end
