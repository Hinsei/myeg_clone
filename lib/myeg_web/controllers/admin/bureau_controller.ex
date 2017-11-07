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

  def edit(conn, %{"id" => id}) do
    user = get_session(conn, :current_user)
    with :ok            <- Bodyguard.permit(Services, :edit_bureau, user, Services),
         {:ok, bureau}  <- Services.get_bureau(id),
    do:  render(conn, "edit.html",bureau: bureau, changeset: Services.bureau_changes(bureau, %{}))
  end

  def show(conn, %{"id" => id}) do
    user = get_session(conn, :current_user)
    with :ok           <- Bodyguard.permit(Services, :show_bureau, user, Services),
         {:ok, bureau} <- Services.get_bureau(id),
    do:  render(conn, "show.html", bureau: bureau)
  end
end
