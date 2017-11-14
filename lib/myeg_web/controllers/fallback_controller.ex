defmodule MyegWeb.FallbackController do
  use MyegWeb, :controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:forbidden)
    |> render(MyegWeb.ErrorView, :"403", error_message: "Access Failed Please Try Again")
  end
end
