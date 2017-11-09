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
  Creates a specialty
  """
  def create_specialty(attrs) do
    %Specialty{}
    |> Specialty.changeset(attrs)    
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

  @doc """
  Used in admin specialty_controller to format params from client to create a valid changeset
  """
  @spec format_specialty_params(map) :: map
  def format_specialty_params(%{"bureau_id" => bureau_id, "specialty" => specialty}) do
    specialty
    |> Enum.map(fn {k, v} ->
          new_value = Regex.replace(~r/\s+/, v, "_")
          {k, new_value}
       end)
    |> Enum.into(%{})
    |> Map.put("bureau_id", bureau_id)
    |> Enum.reduce(%{}, fn {x, y}, acc ->
      case Regex.match?(~r/form_data/, x) do
        true ->
          acc = 
            case Map.get(acc, "form_data") do
              nil -> Map.put(acc, "form_data", [])
              _ -> acc
            end
          old_list = Map.get(acc, "form_data")
          new_list =
            case y do
              ""  -> old_list
              _   -> old_list ++ [y]
            end
          Map.put(acc, "form_data", new_list)
        false ->
          Map.put(acc, x, y)
      end
    end)
  end
end


