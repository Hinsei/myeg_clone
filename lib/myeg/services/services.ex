defmodule Myeg.Services do
  alias Myeg.Services.{Bureau, Specialty}
  alias Myeg.{Accounts, Repo}
  @behaviour Bodyguard.Policy

  @doc """
  Admin can do anything.
  Users cant
  """
  def authorize(_, %Accounts.User{role: role}, _) when role != :user, do: true
  def authorize(_, %Accounts.User{role: role}, _) when role == :user, do: false

  @doc """
  Return a bureau  
  """
  def get_bureau(id) do
    case Repo.get(Bureau, id) do
      nil     -> {:error, :not_found}
      bureau  -> 
        bureau = 
          bureau
          |> Repo.preload(:specialties)
        {:ok, bureau}
    end
  end

  @doc """
  Return list of bureaus
  """
  def list_bureaus() do
    Repo.all(Bureau)
  end

  @doc """
  Creates a bureau
  """
  def create_bureau(attrs) do
    %Bureau{}
    |> Bureau.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Return changeset of bureau to look at changes
  """
  def bureau_changes(bureau \\ %Bureau{}, attrs\\ %{}) do
    Bureau.changeset(bureau, attrs)
  end

  @doc """
  Return changeset of specialty to look at changes
  """
  def specialty_changes(specialty \\ %Specialty{}, attrs \\ %{}) do
    Specialty.changeset(specialty, attrs)
  end
end


