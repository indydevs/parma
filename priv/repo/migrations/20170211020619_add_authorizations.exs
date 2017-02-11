defmodule Parma.Repo.Migrations.CreateAuthorization do
  use Ecto.Migration

  def change do
    create table(:authorizations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :provider, :string
      add :uid, :string
      add :token, :text
      add :refresh_token, :text
      add :expires_at, :integer
      add :user_id, references(:users, on_delete: :delete_all, type: :uuid)
      timestamps()
    end
    create index(:authorizations, [:provider, :uid], unique: true)
    create index(:authorizations, [:expires_at])
    create index(:authorizations, [:provider, :token])

  end
end
