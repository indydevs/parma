defmodule Parma.User do
  use Parma.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :name, :string
    field :email, :string

    has_many :authorizations, Parma.Authorization
    many_to_many :repositories, Parma.Repository, join_through: "users_repositories"

    timestamps()
  end

  @required_fields ~w(email name)a

  def registration_changeset(model, params \\ :empty) do
    user = model
    |> cast(params, ~w(email name)a)
    |> validate_required(@required_fields)
    user
  end

  def github_client(model) do
    token = Parma.Repo.get_by(Parma.Authorization, user_id: model.id).token
    Tentacat.Client.new(%{access_token: token})
  end
end
