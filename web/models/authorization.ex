defmodule Parma.Authorization do
  use Parma.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "authorizations" do
    field :provider, :string
    field :uid, :string
    field :token, :string
    field :refresh_token, :string
    field :expires_at, :integer
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    belongs_to :user, Parma.User

    timestamps()
  end

  @required_fields ~w(provider uid user_id token)a
  @optional_fields ~w(refresh_token expires_at)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint(:provider_uid)
  end
end
