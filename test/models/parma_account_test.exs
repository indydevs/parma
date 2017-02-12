defmodule Parma.ParmaAccountTest do
  use Parma.ModelCase

  alias Parma.ParmaAccount

  @valid_attrs %{repository_id: 42, total: 42, user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ParmaAccount.changeset(%ParmaAccount{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ParmaAccount.changeset(%ParmaAccount{}, @invalid_attrs)
    refute changeset.valid?
  end
end
