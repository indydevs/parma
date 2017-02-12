defmodule UserInitialization do
  @moduledoc false
  use Toniq.Worker
  alias Parma.Repository

  def perform(user: user) do
    repositories = Tentacat.Repositories.list_mine(Parma.User.github_client(user))
    Enum.map(repositories, fn(repo) -> build_repo(user, repo) |> Parma.Repo.insert end)
  end

  def build_repo(user, data) do
     application_id = Parma.Repo.get_by(Parma.Application, name: "github").id
     Repository.changeset(
       Ecto.build_assoc(user, :repositories),
       %{name: data["name"], application_id: application_id, source_id: Integer.to_string(data["id"]), meta: data }
     )
  end
end
