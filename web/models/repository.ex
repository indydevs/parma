defmodule Parma.Repository do
  use Parma.Web, :model

  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id
  schema "repositories" do
    field :name, :string
    field :meta, :map
    field :enabled, :boolean
    field :source_id, :string

    belongs_to :application, Parma.Application
    belongs_to :user, Parma.User
    timestamps()
  end

  @required_fields ~w(name meta source source_id)a
  @optional_fields ~w()a

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
