defmodule Myeg.Authentication do

  def verify(%{"email" => email, "password" => pw}) do
    with {:ok, user} <- Myeg.Accounts.get_user_by_email(email),
         true        <- Comeonin.Argon2.checkpw(pw, user.password_hash),
    do: {:ok, user}
    user = Myeg.Accounts.get_user_by_email(email)
  end
end
