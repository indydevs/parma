defmodule Parma.ParmaAccount do
  use Parma.Web, :model

  schema "parma_accounts" do
    field :user_id, :integer
    field :repository_id, :integer
    field :total, :integer

    timestamps()
  end

  @required_fields ~w(repository_id user_id total)a
  @optional_fields ~w()a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :repository_id, :total])
    |> validate_required([:user_id, :repository_id, :total])
  end
end
