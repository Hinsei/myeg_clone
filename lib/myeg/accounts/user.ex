defmodule Myeg.Accounts.User do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  @derive {
    Poison.Encoder,
    only: [:email]
  }

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :role, Myeg.Enum.Role, default: :user

    has_many :submissions, Myeg.Accounts.Submission

    timestamps()
  end

  def create_changeset(struct, attrs) do
    struct
    |> cast(attrs, [:email, :password])
    |> encrypt_password()
    |> validate_required([:email, :password_hash])
  end

  def update_changeset(struct, attrs) do
    struct
    |> cast(attrs, [:email, :role])
  end

  def encrypt_password(changeset) do
    changeset
    |> get_field(:password)
    |> case do
        nil ->  add_error(changeset, :password, "Cannot be blank")
        ""  ->  add_error(changeset, :password, "Cannot be blank")
        pw when length(pw) <= 4 -> add_error(changeset, :password, "Too short, atleast 5 characters")
        pw  ->
          hashed_pw = Comeonin.Argon2.hashpwsalt(pw) 
          put_change(changeset, :password_hash, hashed_pw)
       end
  end
end
