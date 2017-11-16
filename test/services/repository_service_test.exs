defmodule Parma.RepositoryServiceTest do
  use ExUnit.Case, async: false
  use Parma.SetupCase

  import Mock
  import Parma.Factory

  alias Parma.RepositoryService
  alias Tentacat.Hooks

  describe "#enabled" do
    test "enables the repo and create hooks in remote repo" do
      mock_response = Poison.encode!(%{id: 101, owner: "owner", name: "name"})
      hook_body = %{
        "name" => Application.get_env(:parma, :app_name),
        "active" => true,
        "events" => [ "push", "pull_request" ],
        "config" => %{
          "url" => Application.get_env(:parma, Mix.env)["webhook_callback"],
          "content_type" => "json"
        }
      }

      repository = insert(:repository, enabled: false, meta: %{"owner" => %{"login" => "taher435" }})
      user = insert(:user, repositories: [repository])
      auth = insert(:authorization, user: user)
      client = Tentacat.Client.new(%{access_token: auth.token})

      with_mock Hooks, [create: fn(_owner, _name, _body, _client) -> mock_response end] do
        {result, record} = RepositoryService.enable(repository, user)

        assert result == :ok
        assert record.enabled == true
        assert record.hook_id == "101"
        assert called Hooks.create("taher435", repository.name, hook_body, client)
      end
    end

    test "returns not found if invalid object is passed" do
      {result, message} = RepositoryService.enable(nil, nil)

      assert result == :not_found
      assert message == "Repository Not Found"
    end
  end

  describe "#disable" do
    test "disables the repo and deletes hooks in remote repo" do
      repository = insert(:repository, enabled: true, hook_id: "101", meta: %{"owner" => %{"login" => "taher435" }})
      user = insert(:user, repositories: [repository])
      auth = insert(:authorization, user: user)
      client = Tentacat.Client.new(%{access_token: auth.token})

      with_mock Hooks, [remove: fn(_, _, _, _) -> :ok end] do
        {result, record} = RepositoryService.disable(repository, user)

        assert result == :ok
        assert record.enabled == false
        assert record.hook_id == nil
        assert called Hooks.remove("taher435", repository.name, "101", client)
      end
    end

    test "returns not found if invalid object is passed" do
      {result, message} = RepositoryService.disable(nil, nil)

      assert result == :not_found
      assert message == "Repository Not Found"
    end

    test "returns not found if hook_id is nil" do
      repository = insert(:repository, hook_id: nil)
      user = insert(:user, repositories: [repository])

      {result, message} = RepositoryService.disable(repository, user)

      assert result == :not_found
      assert message == "Repository Not Found"
    end
  end
end
