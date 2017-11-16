defmodule Parma.RepositoryTest do
  use Parma.ModelCase
  import Parma.Factory

  alias Parma.Repository

  test "#changeset with valid attributes" do
    application = insert(:application)
    valid_attributes = params_for(:repository, application: application)

    changeset = Repository.changeset(%Repository{}, valid_attributes)

    assert changeset.valid?
  end

  test "#changeset with invalid attributes" do
    changeset = Repository.changeset(%Repository{}, %{})
    refute changeset.valid?
  end

  test "#update given params to DB" do
    repository = insert(:repository, name: "Repo one")
    {result, record} = Repository.update(repository, %{name: "Repo two"})

    assert result == :ok
    assert record.name == "Repo two"
  end
end
