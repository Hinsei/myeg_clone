defmodule Myeg.Services do
  alias Myeg.Services.Bureau

  @doc """
  Return a bureau  
  """
  def get_bureau(id) do
    Repo.get(Bureau, id)
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
end

