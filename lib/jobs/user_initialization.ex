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

    repository = 
      case Repo.one(query) do
        nil -> 
          insert_params = %{name: data["name"], application_id: application_id, source_id: source_id, meta: data}
          %Repository{}
          |> Repository.changeset(insert_params)
          |> Repo.insert!()
        record -> record
      end
    
    create_user_repository(repository, user)
  end

  def create_user_repository(repository, user) do
    changeset = 
      repository
      |> Repo.preload(:users)
      |> Repository.changeset(%{})
      |> Ecto.Changeset.put_assoc(:users, [user])

    Repo.update!(changeset)
  end
end
