defmodule Parma.Repo do
  use Ecto.Repo, otp_app: :parma

  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end
end
