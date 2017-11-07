defmodule MyegWeb.PageController do
  use MyegWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", conn: conn, bureaus: Myeg.Services.list_bureaus()
  end
end
