defmodule MyegWeb.Admin.SpecialtyController do
  use MyegWeb, :controller

  def new(conn, %{"bureau_id" => bureau_id}) do
    with {:ok, bureau} <- Myeg.Services.get_bureau(bureau_id)
    do    changeset = Myeg.Services.specialty_changes()
          render(conn, "new.html", bureau: bureau, changeset: changeset)
    end
  end

  def create(conn, params) do
    params
    |> Myeg.Services.format_specialty_params() 
    |> Myeg.Services.create_specialty()
    |> case do
      {:ok, specialty} -> 

        conn
        |> put_flash(:info, "Success")
        |> render(MyegWeb.Admin.BureauView, :show, bureau: Myeg.Services.get_bureau(specialty.bureau_id))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error")
        |> render(MyegWeb.PageView, :index)
    end
  end
end
