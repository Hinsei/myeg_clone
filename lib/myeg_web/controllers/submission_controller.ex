defmodule MyegWeb.SubmissionController do
  require IEx
  use MyegWeb, :controller

  def new(conn, %{"specialty_id" => specialty_id}) do
    with {:ok, _}         <- current_user(conn),
         {:ok, specialty} <- Myeg.Services.get_specialty(specialty_id)
    do 
      changeset = Myeg.Accounts.changes_submission()
      conn
      |> render("new.html", specialty: specialty, changeset: changeset)
    else
      {:error, :not_signed_in} ->
        conn
        |> put_flash(:error, "You must be signed in before making a submission")
        |> render(MyegWeb.PageView, :index)
    end
  end

  def create(conn, params = %{"specialty_id" => specialty_id}) do
    with {:ok, user} <- current_user(conn),
         {:ok, specialty} <- Myeg.Services.get_specialty(specialty_id),
         {:ok, submission} <- Myeg.Accounts.create_submission(user, params)
    do
      conn
      |> put_flash(:info, "Submission for this service is successful")
      |> render("show.html", specialty: specialty, submission: submission)
    else
      {:error, :not_signed_in} ->
        conn
        |> put_flash(:error, "You must be signed in before making a submission")
        |> render(MyegWeb.PageView, :index)
    end
  end

  def show(conn, %{"specialty_id" => specialty_id, "id" => id}) do
    with {:ok, _user} <- current_user(conn),
         {:ok, specialty} <- Myeg.Services.get_specialty(specialty_id),
         {:ok, submission} <- Myeg.Accounts.get_submission(id)
    do
      render(conn, "show.html", specialty: specialty, submission: submission)
    else
      {:error, :not_signed_in} ->
        conn
        |> put_flash(:error, "You must be signed in before making a submission")
        |> render(MyegWeb.PageView, :index)
    end
  end
end
