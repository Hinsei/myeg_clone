defmodule MyegWeb.API.BureauView do
  use MyegWeb, :view

  def render("show.json", %{bureau: bureau}) do
    bureau
  end

  def render("specialties.json", %{bureau: bureau, specialties: specialties}) do
    %{
      bureau: bureau,
      specialties: Enum.map(specialties, 
                            fn x -> 
                              %{id: x.id, title: x.title} 
                            end)
    }
  end
end
