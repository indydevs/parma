defmodule Parma.Repo.Migrations.CreateApplication do
  use Ecto.Migration

  def change do
    create table(:applications, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end
    create unique_index(:applications, [:name])
  end
end
