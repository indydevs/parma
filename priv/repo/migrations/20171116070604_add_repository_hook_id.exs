defmodule Parma.Repo.Migrations.AddRepositoryHookId do
  use Ecto.Migration

  def change do
    alter table(:repositories) do
      add :hook_id, :string
    end
  end
end
