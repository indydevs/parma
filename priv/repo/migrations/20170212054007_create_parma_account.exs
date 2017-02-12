defmodule Parma.Repo.Migrations.CreateParmaAccount do
  use Ecto.Migration

  def change do
    create table(:parma_accounts) do
      add :id, :uuid, primary_key: true
      add :user_id, :integer
      add :repository_id, references(:repositories, on_delete: :delete_all, type: :uuid)
      add :total, :integer

      timestamps()
    end
    create index(:parma_accounts, [:user_id])
  end
end
