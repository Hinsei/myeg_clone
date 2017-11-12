defmodule Myeg.Accounts do
  alias Myeg.Repo 
  alias Myeg.Accounts.{User, Submission}

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
  Return a submission
  """
  def get_submission(id) do
    Submission
    |> Repo.get(id)
    |> case do
        nil         -> {:error, :not_found}
        submission  -> {:ok, submission}
       end
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
  Create a submission
  """
  def create_submission(user, %{"specialty_id" => specialty_id, "submission" => form_input}) do
    changes =
      %{}
      |> Map.put("specialty_id", specialty_id)
      |> Map.put("user_id", user.id)
      |> Map.put("form_input", form_input)

    %Submission{}
    |> Submission.changeset(changes)
    |> Repo.insert
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
  Update a submission
  """
  def update_submission(submission = %Submission{}, attrs) do
    submission
    |> Submission.changeset(attrs)
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

  @doc """
  Return ecto changeset for submission
  """
  def changes_submission(submission \\ %Submission{}) do
    submission
    |> Submission.changeset(%{})
  end
end
