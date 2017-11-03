defmodule MyegWeb.API.BureauView do
  use MyegWeb, :view

  def render("show.json", %{bureau: bureau}) do
    bureau
  end
end
