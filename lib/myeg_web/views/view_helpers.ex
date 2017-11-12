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

  def format_form_input(input) do
    Regex.replace(~r/_+/, input, " ")
    |> String.split()
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end
end
