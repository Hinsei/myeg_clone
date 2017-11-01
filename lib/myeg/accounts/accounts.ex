defmodule Myeg.Accounts do
  alias Myeg.Repo 
  alias Myeg.Accounts.User

  @doc """
  Return a user
  """
  def get_user(id) do
    User
    |> Repo.get(id)
  end

  @doc """
  Return a user by email
  """
  def get_user_by_email(email) do
    User
    |> Repo.get_by(email: email)
  end

  @doc """
  Return list of users
  """
  def list_users() do
    User
    |> Repo.all()
  end

  @doc """
  Create a user
  """
  def create_user(attrs) do
    %User{}
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update a user
  """
  def update_user(user = %User{}, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user
  """
  def delete_user(user = %User{}) do
    Repo.delete(user)
  end

  @doc """
  Return ecto changeset for user
  """
  def changes_user(user \\ %User{}) do
    user
    |> User.create_changeset(%{})
  end
end
