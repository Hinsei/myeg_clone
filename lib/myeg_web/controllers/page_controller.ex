defmodule MyegWeb.PageController do
  use MyegWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", conn: conn
  end
end
