defmodule MyegWeb.ControllerHelpers do
  import Plug.Conn

  def current_user(conn) do
    case get_session(conn, :current_user) do
      nil ->
        {:error, :not_signed_in}
      user ->
        {:ok, user}
    end
  end
end
