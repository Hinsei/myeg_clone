defmodule MyegWeb.Admin.BureauController do
  alias  Myeg.Services
  use MyegWeb, :controller

  def new(conn, _params) do
    user = get_session(conn, :current_user)
    with :ok <- Bodyguard.permit(Services, :create_bureau, user, Services),
    do: render(conn, "new.html", changeset: Services.bureau_changes())
  end

  def create(conn, %{"bureau" => bureau_info}) do
    user = get_session(conn, :current_user)
    with :ok          <- Bodyguard.permit(Services, :create_bureau, user, Services),
         {:ok, bureau} <- Services.create_bureau(bureau_info)
    do    
      conn
      |> put_flash(:info, "Bureau saved")
      |> render("show.html", bureau: bureau)
    else
      {:error, :unauthorized} ->
        conn
        |> put_status(:forbidden)
        |> render(MyegWeb.ErrorView, :"403")

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Bureau failed to be saved")
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, bureau} <- Myeg.Services.get_bureau(id),
    do:  render(conn, "show.html", bureau: bureau)
  end
end
