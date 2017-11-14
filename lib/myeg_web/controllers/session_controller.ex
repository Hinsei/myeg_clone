defmodule MyegWeb.SessionController do
  use MyegWeb, :controller

  def create(conn, %{"session" => session_info}) do
    with {:ok, user} <- Myeg.Authentication.verify(session_info)
    do   conn
         |> put_session(:current_user, user) 
         |> redirect(to: "/")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: "/")
  end
end
