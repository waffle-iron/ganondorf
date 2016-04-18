defmodule Ganondorf.Router do
  use Ganondorf.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ganondorf do
    pipe_through :browser # Use the default browser stack

    get "/registration", RegistrationController, :new
    post "/registration", RegistrationController, :create
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete

    get  "/authorize", AuthorizationController, :authorize
    post "/authorize", AuthorizationController, :authorize

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ganondorf do
  #   pipe_through :api
  # end
end
