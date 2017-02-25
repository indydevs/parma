defmodule Parma.Repo.Migrations.CreateApplication do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end
    create index(:applications, [:application_id])
    create unique_index(:applications, [:name])
  end
end
