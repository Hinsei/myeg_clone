defmodule MyegWeb.SpecialtyController do
  use MyegWeb, :controller

  def new(conn, %{"id" => id, "type" => type}) do
    render(conn, "new.html")
  end
end
