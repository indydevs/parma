defmodule Parma.Application do
  use Parma.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "applications" do
    field :name, :string

    timestamps()
  end

  @required_fields ~w(name)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint([:name])    
  end
end
