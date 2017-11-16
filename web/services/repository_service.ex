defmodule Parma.RepositoryService do
  @moduledoc """
  Service module for performing actions on the repositories
  """

  alias Parma.Repository
  alias Parma.User

  def enable(%Repository{} = repository, %User{} = user) do
    owner = get_repo_owner(repository)

    {_status, response} = create_hook(owner, repository.name, user)

    Repository.update(repository, %{enabled: true, hook_id: response|> Map.get("id") |> to_string})
  end

  def enable(_, _), do: not_found_error()

  def disable(%Repository{hook_id: hook_id} = repository, %User{} = user)
  when not is_nil(hook_id) do
    owner = get_repo_owner(repository)
    delete_hook(owner, repository.name, hook_id, user)

    Repository.update(repository, %{enabled: false, hook_id: nil})
  end

  def disable(_, _), do: not_found_error()

  # private

  defp not_found_error do
    {:not_found, "Repository Not Found"}
  end

  defp get_repo_owner(%Repository{meta: meta} = _repository) do
    meta |> Map.get("owner") |> Map.get("login")
  end

  defp get_client(user) do
    User.github_client(user)
  end

  defp create_hook(owner, repo_name, user) do
    Tentacat.Hooks.create(owner, repo_name, hook_body(), get_client(user))
  end

  defp delete_hook(owner, repo_name, hook_id, user) do
    Tentacat.Hooks.remove(owner, repo_name, hook_id, get_client(user))
  end

  defp hook_body do
    %{
      "name" => "web",
      "active" => true,
      "events" => [ "push", "pull_request" ],
      "config" => %{
        "url" => Application.get_env(:parma, Mix.env) |> Map.get(:webhook_callback),
        "content_type" => "json"
      }
    }
  end
end
