defmodule Parma.PullRequest do
  use Parma.Web, :model

  schema "pull_requests" do
    field :source_id, :integer
    field :author_id, :integer
    field :total_parma, :integer

    timestamps()
  end

  @required_fields ~w(source_id author_id total_parma)a
  @optional_fields ~w()a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:source_id, :author_id, :total_parma])
    |> validate_required([:source_id, :author_id, :total_parma])
  end
end
