defmodule Parma.ApplicationController do
    @moduledoc """
    Common controller for all Application endpoints
    """
    def controller do
      quote do
        use Parma.Web, :controller
  
        def unauthenticated(conn, _params) do
            conn
            |> put_flash(:error, "Authentication required")
            |> redirect(to: auth_path(conn, :login, :identity))
        end
  
        defp set_current_user(conn, _key_values) do
          conn |> assign(:current_user, Guardian.Plug.current_resource(conn))
        end
      end
    end
  
    defmacro __using__(which) when is_atom(which) do
      apply(__MODULE__, which, [])
    end
  end