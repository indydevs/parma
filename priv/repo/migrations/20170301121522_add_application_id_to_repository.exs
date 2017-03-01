defmodule Parma.Repo.Migrations.AddApplicationIdToRepository do
  use Ecto.Migration

  def change do
    alter table(:repositories) do
      add :application_id, references(:applications, on_delete: :delete_all, type: :uuid)
    end
    create index(:repositories, [:application_id])
  end
end
