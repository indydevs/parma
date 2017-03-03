defmodule Parma.UserRepository do
  use Parma.Web, :model
   @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users_repositories" do
    belongs_to :user, Parma.User
    belongs_to :repository, Parma.Repository
  end

  @required_fields ~w(user_id repository_id)a
  @optional_fields ~w()a

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
