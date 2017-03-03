defmodule Parma.Application do
  use Parma.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "applications" do
    field :name, :string

    timestamps()
  end

  @required_fields ~w(name)a
  @optional_fields ~w()a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> unique_constraint(:name)
    |> validate_required(@required_fields)
  end
end
