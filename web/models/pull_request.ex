defmodule Parma.PullRequest do
  use Parma.Web, :model

  schema "pull_requests" do
    field :source_id, :integer
    field :author_id, :integer
    field :calculated_parma, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:source_id, :author_id, :calculated_parma])
    |> validate_required([:source_id, :author_id, :calculated_parma])
  end
end
