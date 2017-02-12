defmodule Parma.ParmaTransactionTest do
  use Parma.ModelCase

  alias Parma.ParmaTransaction

  @valid_attrs %{parma_account_id: 42, transaction_amount: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ParmaTransaction.changeset(%ParmaTransaction{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ParmaTransaction.changeset(%ParmaTransaction{}, @invalid_attrs)
    refute changeset.valid?
  end
end
