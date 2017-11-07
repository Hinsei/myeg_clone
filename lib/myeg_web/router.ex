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

    get "/bureaus/:id", BureauController, :show

    post "/sessions",   SessionController,  :create
    delete "/sessions", SessionController,  :delete

    get "/specialties/new", SpecialtyController,  :new
    post "/specialties",     SpecialtyController,  :create
  end

  scope"/admin", MyegWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/bureaus", BureauController
  end

  # Other scopes may use custom stacks.
  scope "/api", MyegWeb.API do
    pipe_through :api

    get "/bureaus/:id", BureauController, :show

  end
end
