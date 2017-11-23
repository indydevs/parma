defmodule Parma.SetupCase do
  use ExUnit.CaseTemplate

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Parma.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Parma.Repo, {:shared, self()})
    end

    on_exit fn ->
      Ecto.Adapters.SQL.Sandbox.checkin(Parma.Repo, [])
    end

    :ok
  end
end

