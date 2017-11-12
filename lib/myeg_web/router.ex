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

    get "/specialties/:specialty_id/submissions/new", SubmissionController, :new
    get "/specialties/:specialty_id/submissions/:id", SubmissionController, :show
    post "/specialties/:specialty_id/submissions",    SubmissionController, :create
    get "/submissions/:submission_id/checkout", SubmissionController, :checkout
    post "/submissions/:submission_id/payment", SubmissionController, :payment
  end

  scope"/admin", MyegWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/bureaus", BureauController do
      resources "/specialties", SpecialtyController, only: [:new, :create]
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", MyegWeb.API do
    pipe_through :api

    get "/bureaus/:id", BureauController, :show
    get "/bureaus/:id/specialties", BureauController, :specialties 
  end
end
