defmodule Parma.Application do
  use Parma.Web, :model

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
    |> validate_required(@required_fields)
  end
end
