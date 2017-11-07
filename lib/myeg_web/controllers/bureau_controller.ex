defmodule MyegWeb.BureauController do
  use MyegWeb, :controller
  alias Myeg.Services

  def show(conn, %{"id" => id}) do
    with {:ok, bureau} <- Services.get_bureau(id),
    do:  render(conn, "show.html", bureau: bureau)
  end
end
