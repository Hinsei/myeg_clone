defmodule MyegWeb.API.UserView do
  use MyegWeb, :view

  def render("create.json", %{user: user}) do
    user
  end
end
