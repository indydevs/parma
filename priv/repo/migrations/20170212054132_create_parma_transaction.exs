defmodule Parma.Repo.Migrations.CreateParmaTransaction do
  use Ecto.Migration

  def change do
    create table(:parma_transactions) do
      add :id, :uuid, primary_key: true
      add :parma_account_id, :integer
      add :transaction_amount, :integer
      add :pull_request_id, :integer

      timestamps()
    end
    create index(:parma_transactions, [:parma_account_id])
  end
end
