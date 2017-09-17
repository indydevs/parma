defmodule Parma.PullRequest do
  use Parma.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "pull_requests" do
    field :source_id, :integer
    field :author_id, :integer
    field :total_parma, :integer

    timestamps()
  end

  @required_fields ~w(source_id author_id total_parma)a  

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
