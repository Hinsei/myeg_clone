defmodule MyegWeb.UserController do
  use MyegWeb, :controller

  def new(conn, _params) do
    changeset = Myeg.Accounts.changes_user()
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_info}) do
    with  {:ok, user} <- Myeg.Accounts.create_user(user_info)
    do    
          conn
          |> assign(:current_user, user)
          |> redirect(to: "/")
    else  
          {:error, _changeset} ->
            redirect(conn, to: "/users/new")
    end
  end
end
