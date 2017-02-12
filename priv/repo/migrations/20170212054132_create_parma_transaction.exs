defmodule Parma.Repo.Migrations.CreateParmaTransaction do
  use Ecto.Migration

  def change do
    create table(:parma_transactions) do
      add :id, :uuid, primary_key: true
      add :parma_account_id, references(:parma_accounts, on_delete: :delete_all, type: :uuid)
      add :transaction_amount, :integer
      add :pull_request_id, references(:pull_requests, on_delete: :delete_all, type: :uuid)

      timestamps()
    end
    create index(:parma_transactions, [:parma_account_id])
  end
end
