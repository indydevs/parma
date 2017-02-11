defmodule Parma.GuardianToken do
  use Parma.Web, :model

  alias Parma.Repo
  alias Parma.GuardianSerializer

  @primary_key {:id, :binary_id, autogenerate: false}
  schema "guardian_tokens" do
    field :aud, :string
    field :iss, :string
    field :sub, :string
    field :exp, :integer
    field :jwt, :string
    field :claims, :map

    timestamps
  end

  def for_user(user) do
    case GuardianSerializer.for_token(user) do
      {:ok, aud} ->
        (from t in Parma.GuardianToken, where: t.sub == ^aud)
          |> Repo.all
      _ -> []
    end
  end
end