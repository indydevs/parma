defmodule Parma.Repo.Migrations.CreatePullRequest do
  use Ecto.Migration

  def change do
    create table(:pull_requests) do
      add :id, :uuid, primary_key: true
      add :source_id, :integer
      add :repository_id, :integer
      add :author_id, :integer
      add :calculated_parma, :integer

      timestamps()
    end
    create index(:pull_requests, [:source_id])
  end
end
