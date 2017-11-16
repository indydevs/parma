defmodule Parma.Router do
  use Parma.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Parma do
    pipe_through [:browser, :browser_auth]
    get "/", PageController, :index
    get "/logout", AuthController, :logout
  end

  scope "/auth", Parma do
    pipe_through [:browser, :browser_auth] # Use the default browser stack
    get "/:identity", AuthController, :login
    get "/:identity/callback", AuthController, :callback
    post "/:identity/callback", AuthController, :callback
  end

  scope "/repositories", Parma do
    pipe_through [:browser, :browser_auth]
    get "/", RepositoryController, :index
    put "/:id", RepositoryController, :update
  end
end
