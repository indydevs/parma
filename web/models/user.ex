defmodule Parma.User do
  use Parma.Web, :model

  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :email, :string

    has_many :authorizations, Parma.Authorization

    timestamps()
  end

  @required_fields ~w(email name)a
  @optional_fields ~w()a

  def registration_changeset(model, params \\ :empty) do
    model
    |>cast(params, ~w(email name)a)
    |> validate_required(@required_fields)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email])
    |> validate_required([:name, :email])
  end

  def repositories(model) do
    Tentacat.Repositories.list_mine(github_client(model))
  end

  def github_client(model) do
    token = Parma.Repo.get_by(Parma.Authorization, user_id: model.id).token
    Tentacat.Client.new(%{access_token: token})
  end
end
