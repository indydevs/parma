defmodule Parma.RepositoryControllerTest do
    use Parma.ConnCase, async: false
    use Parma.SetupCase
    use Parma.AuthHelper

    import Parma.Factory
    import Mock

    alias Parma.RepositoryService

    describe "#index" do
      test "#index gives a list of user repositories" do
        user_with_repo = user_with_repositories()
        conn = build_conn()

        response =
          conn
          |> guardian_login(user_with_repo)
          |> get(repository_path(conn, :index))

        for repository <- user_with_repo.repositories do
          assert html_response(response, 200) =~ repository.name
        end
      end
    end

    describe "#update" do
      test "returns success when repo is enabled successfully" do
        repository = insert(:repository)
        user = insert(:user)
        conn = build_conn()

        with_mock RepositoryService, [enable: fn(_, _) -> {:ok, true} end] do
          response =
            conn
            |> guardian_login(user)
            |> put(repository_path(conn, :update, repository.id, %{enable: "true"}))

          assert json_response(response, 200) == %{
            "status" => 200,
            "message" => "Repository updated"
          }
        end
      end

      test "returns success when repo is disabled successfully" do
        repository = insert(:repository)
        user = insert(:user)

        with_mock RepositoryService, [disable: fn(_, _) -> {:ok, true} end] do
          response =
            build_conn()
            |> guardian_login(user)
            |> put(repository_path(build_conn(), :update, repository.id, %{enable: "false"}))

          assert json_response(response, 200) == %{
            "status" => 200,
            "message" => "Repository updated"
          }
        end
      end

      test "returns 404 if repository does not exists" do
        user = insert(:user)

        response =
          build_conn()
          |> guardian_login(user)
          |> put(repository_path(build_conn(), :update, SecureRandom.uuid))

        assert json_response(response, 404) == %{
          "status" => 404,
          "message" => "Object not found"
        }
      end

      test "returns 404 if service returns :not_found" do
        repository = insert(:repository)
        user = insert(:user)

        with_mock RepositoryService, [enable: fn(_, _) -> {:not_found, false} end] do
          response =
            build_conn()
            |> guardian_login(user)
            |> put(repository_path(build_conn(), :update, repository.id, %{enable: "true"}))

          assert json_response(response, 404) == %{
            "status" => 404,
            "message" => "Object not found"
          }
        end
      end

      test "returns 500 if service returns :error" do
        repository = insert(:repository)
        user = insert(:user)

        with_mock RepositoryService, [enable: fn(_, _) -> {:error, false} end] do
          response =
            build_conn()
            |> guardian_login(user)
            |> put(repository_path(build_conn(), :update, repository.id, %{enable: "true"}))

          assert json_response(response, 500) == %{
            "status" => 500,
            "message" => "Internal server error"
          }
        end
      end
    end
  end
