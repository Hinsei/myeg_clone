defmodule MyegWeb.ViewHelpers do
  import Plug.Conn

  def current_user(conn) do
    case get_session(conn, :current_user) do
      nil   ->
        nil
      user  -> 
        user
    end
  end
end
