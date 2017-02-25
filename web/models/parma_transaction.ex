defmodule Parma.ParmaTransaction do
  use Parma.Web, :model

  schema "parma_transactions" do
    field :parma_account_id, :integer
    field :transaction_amount, :integer

    timestamps()
  end

  @required_fields ~w(parma_account_id transaction_amount)a
  @optional_fields ~w()a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:parma_account_id, :transaction_amount])
    |> validate_required(@required_fields)
  end
end
