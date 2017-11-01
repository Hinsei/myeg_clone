defmodule Myeg.Authentication do

  def verify(%{"email" => email, "password" => pw}) do
    user = Myeg.Accounts.get_user_by_email(email)
    case Comeonin.Argon2.checkpw(pw, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized}
    end
  end

end
