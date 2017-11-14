defmodule Parma.AuthHelper do
  @moduledoc """
  Mixin to provide helper methods to login during tests
  """
  defmacro __using__(_) do
    quote do
      def build_authorized_conn(%Parma.User{} = user) do
        {:ok, jwt, full_claims} = Guardian.Plug.sign_in(user, :token)

        build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
      end

      def guardian_login(%Plug.Conn{} = conn, user, opts \\ []) do
        conn
          |> bypass_through(Parma.Router, [:browser])
          |> get("/")
          |> Guardian.Plug.sign_in(user, :token, opts)
          |> send_resp(200, "Flush the session")
          |> recycle()
      end
    end
  end
end
