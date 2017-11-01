defmodule MyegWeb.Router do
  use MyegWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyegWeb do
    pipe_through :browser # Use the default browser stack

    get "/",            PageController,     :index
    get "/users/new",   UserController,     :new
    post "/users",      UserController,     :create
    post "/sessions",   SessionController,  :create
    delete "/sessions", SessionController,  :delete
  end

  # Other scopes may use custom stacks.
  #  scope "/api", MyegWeb.API do
  #    pipe_through :api
  #
  #  end
end
