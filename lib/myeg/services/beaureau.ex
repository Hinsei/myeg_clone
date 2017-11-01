defmodule Myeg.Services.Bureau do
  alias Myeg.Services.Bureau
  use Ecto.Schema
  import Ecto.Changeset

  schema "bureaus" do
    field :name, :string
    field :email, :string
    field :location, :string
    field :logo, :string
    field :mobile, :string
  end

  def changeset(struct = %Bureau{}, attrs \\ %{}) do
    struct
    |> cast(attrs, [:name, :email, :location, :logo, :mobile])
    |> validate_required([:name, :email, :location, :logo, :mobile])
  end

end
