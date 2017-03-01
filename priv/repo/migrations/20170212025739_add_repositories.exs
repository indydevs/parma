defmodule Parma.Repo.Migrations.AddRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :meta, :map
      add :source_id, :string
      add :enabled, :boolean, default: false
      timestamps()
    end
    create index(:repositories, [:source_id])
    create index(:repositories, [:name])
  end
end
