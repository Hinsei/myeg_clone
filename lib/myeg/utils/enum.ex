defmodule Myeg.Enum do
  defmodule Role do
    @behaviour Ecto.Type
    def type, do: :integer

    def cast(role) when is_integer(role) do
      value = 
        case role do
          0 -> :user
          1 -> :admin
          2 -> :superadmin
        end
      {:ok, value}
    end
    def cast(role) when is_binary(role), do: {:ok, role} 
    def cast(role) when is_atom(role), do: {:ok, role} 
    def cast(_), do: :error 

    def load(data) when is_integer(data) do
      role =
        case data do
          0 -> :user
          1 -> :admin
          2 -> :superadmin
        end
      {:ok, role}
    end

    def dump(role) when is_atom(role) do
      integer =
        case role do
          :user       -> 0
          :admin      -> 1
          :superadmin -> 2
        end
      {:ok, integer}
    end

    def dump(role) when is_binary(role) do
      integer =
        case role do
          "user"        -> 0
          "admin"       -> 1
          "superadmin"  -> 2
        end
      {:ok, integer}
    end
    def dump(_), do: :error
  end

  defmodule TypeOfService do
    @behaviour Ecto.Type
    def type, do: :integer

    def cast(type) when is_integer(type) do
      service =
        case type do
          0 -> :summons_checking
        end
      {:ok, service}
    end
    def cast(type) when is_binary(type), do: {:ok, type}
    def cast(type) when is_atom(type), do: {:ok, type}
    def cast(_), do: :error

    def load(type) when is_integer(type) do
      service =
        case type do
          0 -> :summons_checking 
        end
      {:ok, service}
    end

    def dump(type) when is_atom(type) do
      service = 
        case type do
          :summons_checking -> 0
        end
      {:ok, service}
    end
    def dump(type) when is_binary(type) do
      service =
        case type do
          "summons_checking" -> 0
        end
      {:ok, service}
    end
    def dump(_), do: :error
  end
end
