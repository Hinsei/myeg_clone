defmodule MyegWeb.API.BureauController do 
  use MyegWeb, :controller

  def show(conn, %{"id" => id}) do
    with {:ok, bureau} <- Myeg.Services.get_bureau(id), 
    do: render(conn, "show.json", bureau: bureau)
  end

  def specialties(conn, %{"id" => id}) do
    with {:ok, bureau} <- Myeg.Services.get_bureau(id)
    do 
      specialties =
        bureau
        |> Map.get(:specialties)
        |> Enum.map(&Myeg.Services.format_specialty_title/1)

      render(conn, "specialties.json", bureau: bureau, specialties: specialties)
    end
  end
end
