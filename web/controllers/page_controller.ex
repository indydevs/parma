defmodule Parma.PageController do
  use Parma.ApplicationController, :controller

  plug EnsureAuthenticated, handler: __MODULE__

  def index(conn, _params, current_user, _claims) do
    render conn, "index.html", current_user: current_user
  end
end
