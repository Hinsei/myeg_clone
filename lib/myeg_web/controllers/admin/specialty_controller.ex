defmodule MyegWeb.Admin.SpecialtyController do
  use MyegWeb, :controller

  def new(conn, %{"bureau_id" => bureau_id}) do
    with {:ok, bureau} <- Myeg.Services.get_bureau(bureau_id)
    do    changeset = Myeg.Services.specialty_changes()
          render(conn, "new.html", bureau: bureau, changeset: changeset)
    end
  end
end
