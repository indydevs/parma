defmodule Parma.Repo.Migrations.AddUsersRepositories do
  use Ecto.Migration

  def change do
    create table(:users_repositories, primary_key: false) do
      add :repository_id, references(:repositories, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
