defmodule Parma.Repo.Migrations.CreateGuardianDb do
  use Ecto.Migration

  def change do
    create table(:guardian_tokens, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :jti, :uuid, primary_key: true
      add :aud, :uuid, primary_key: true
      add :typ, :string
      add :iss, :string
      add :sub, :string
      add :exp, :bigint
      add :jwt, :text
      add :claims, :map
      timestamps()
    end

    create index(:guardian_tokens, [:typ])
  end
end
