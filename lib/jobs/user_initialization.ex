defmodule UserInitialization do
  @moduledoc false
  use Toniq.Worker
  alias Parma.Repository

  def perform(user: user) do
    repositories = Tentacat.Repositories.list_mine(Parma.User.github_client(user))
    Enum.map(repositories, fn(repo) -> build_repo(user, repo) |> Parma.Repo.insert end)
  end

  def build_repo(user, data) do
     Repository.changeset(
       Ecto.build_assoc(user, :repositories),
       %{name: data["name"], source: "github", source_id: Integer.to_string(data["id"]), meta: data }
     )
  end
end
