defmodule UserInitialization do
  @moduledoc false
  use Toniq.Worker
  alias Parma.Repository
  alias Parma.Repo
  alias Parma.Application
  import Ecto.Query, only: [from: 2]

  def perform(user: user) do
    repositories = Tentacat.Repositories.list_mine(Parma.User.github_client(user))
    Enum.map(repositories, fn(repo) -> find_or_create_repo(user, repo) end)
  end

  def find_or_create_repo(user, data) do
    application_id = Repo.get_by(Application, name: "github").id
    source_id = Integer.to_string(data["id"])
    query = from r in Repository,
            where: r.application_id == ^application_id and r.source_id == ^source_id
    repository = Repo.one(query)
    if !repository do
      {_, repository} = Repo.insert(
        Repository.changeset(
          %Repository{},
          %{name: data["name"], application_id: application_id, source_id: source_id, meta: data }
        )
      )
    end
    create_user_repository(repository, user)
  end

  def create_user_repository(repository, user) do
    user = user |> Repo.preload(:repositories)
    repository =  repository |> Repo.preload(:users)
    changeset = Ecto.Changeset.change(user) |> Ecto.Changeset.put_assoc(:repositories, [repository])
    Repo.update!(changeset)
  end
end
