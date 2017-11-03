defmodule MyegWeb.API.BureauController do 
  use MyegWeb, :controller

  def show(conn, %{"id" => id}) do
    with {:ok, bureau} <- Myeg.Services.get_bureau(id), 
    do: render(conn, "show.json", bureau: bureau)
  end
end
