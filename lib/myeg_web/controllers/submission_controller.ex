defmodule MyegWeb.SubmissionController do
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
        |> render(MyegWeb.PageView, :index, bureaus: Myeg.Services.list_bureaus())
    end
  end

  def create(conn, params = %{"specialty_id" => specialty_id, "payable" => "false"}) do
    with {:ok, user} <- current_user(conn),
         {:ok, specialty} <- Myeg.Services.get_specialty(specialty_id),
         {:ok, submission} <- Myeg.Accounts.create_submission(user, params)
    do
      rand = :crypto.strong_rand_bytes(16) |> Base.url_encode64()
      new_form_input = Map.put(submission.form_input, "service_identification_number", rand)
      changes = %{processed: true, form_input: new_form_input}
      {:ok, submission} = Myeg.Accounts.update_submission(submission, changes)
      conn
      |> put_flash(:info, "Submission for this service is successful")
      |> render("show.html", specialty: specialty, submission: submission)
    else
      {:error, :not_signed_in} ->
        conn
        |> put_flash(:error, "You must be signed in before making a submission")
        |> render(MyegWeb.PageView, :index, bureaus: Myeg.Services.list_bureaus())
    end
  end

  def create(conn, params = %{"specialty_id" => specialty_id, "payable" => "true"}) do
    with {:ok, user} <- current_user(conn),
         {:ok, _specialty} <- Myeg.Services.get_specialty(specialty_id),
         {:ok, submission} <- Myeg.Accounts.create_submission(user, params)
    do
      conn
      |> put_flash(:info, 
                   "Submission for this service is sucessful, payment has to be made before it can be processed.")
      |> render("checkout.html", submission: submission)
    else
      {:error, :not_signed_in} ->
        conn
        |> put_flash(:error, "You must be signed in before making a submission")
        |> render(MyegWeb.PageView, :index, bureaus: Myeg.Services.list_bureaus())
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
        |> render(MyegWeb.PageView, :index, bureaus: Myeg.Services.list_bureaus())
    end
  end

  def checkout(conn, %{"submission_id" => submission_id}) do
    with {:ok, _user} <- current_user(conn),
         {:ok, submission} <- Myeg.Accounts.get_submission(submission_id)
    do
      render(conn, "checkout.html", submission: submission)
    else
      {:error, :not_signed_in} ->
        conn
        |> put_flash(:error, "You must be signed in before making a submission")
        |> render(MyegWeb.PageView, :index, bureaus: Myeg.Services.list_bureaus())
    end
  end

  def payment(conn, %{"submission_id" => submission_id}) do
    with {:ok, _user} <- current_user(conn),
         {:ok, submission} <- Myeg.Accounts.get_submission(submission_id),
         {:ok, _submission} <- Myeg.Accounts.update_submission(submission, %{processed: true})
    do
      conn
      |> put_flash(:info, "Payment successfull")
      |> render(MyegWeb.PageView, :index, bureaus: Myeg.Services.list_bureaus())
    else
      {:error, :not_signed_in} ->
        conn
        |> put_flash(:error, "You must be signed in before making a submission")
        |> render(MyegWeb.PageView, :index, bureaus: Myeg.Services.list_bureaus())
    end
  end
end
