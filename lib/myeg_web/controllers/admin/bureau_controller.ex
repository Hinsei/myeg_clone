defmodule MyegWeb.Admin.BureauController do
  alias  Myeg.Services
  use MyegWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html", changeset: Services.bureau_changes())
  end

  def create(conn, %{"bureau" => bureau_info}) do
    with {:ok, bureau} <- Services.create_bureau(bureau_info)
    do    
      conn
      |> put_flash(:info, "Bureau saved")
      |> render("show.html", bureau: bureau)
    else
      {:error, changeset} ->
      conn
      |> put_flash(:error, "Bureau failed to be saved")
      |> render("new.html", changeset: changeset)
    end
  end
end
