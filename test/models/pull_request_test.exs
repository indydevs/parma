defmodule Parma.PullRequestTest do
  use Parma.ModelCase

  alias Parma.PullRequest

  @valid_attrs %{author_id: 42, calculated_parma: 42, source_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PullRequest.changeset(%PullRequest{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PullRequest.changeset(%PullRequest{}, @invalid_attrs)
    refute changeset.valid?
  end
end
