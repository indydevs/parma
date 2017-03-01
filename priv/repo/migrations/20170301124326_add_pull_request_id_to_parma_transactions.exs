defmodule Parma.Repo.Migrations.AddPullRequestIdToParmaTransactions do
  use Ecto.Migration

  def change do
    alter table(:parma_transactions) do
      add :pull_request_id, references(:pull_requests, on_delete: :delete_all, type: :uuid)
    end
  end
end
