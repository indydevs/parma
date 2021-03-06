defmodule Parma.Repository do
  use Parma.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "repositories" do
    field :name, :string
    field :meta, :map
    field :enabled, :boolean
    field :source_id, :string
    field :hook_id, :string

    belongs_to :application, Parma.Application
    many_to_many :users, Parma.User, join_through: "users_repositories"
    timestamps()
  end

  @required_fields ~w(name meta source_id application_id)a
  @optional_fields ~w(enabled hook_id)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def update(%__MODULE__{} = model, %{} = params) do
    model
    |> changeset(params)
    |> Repo.update
  end
end
