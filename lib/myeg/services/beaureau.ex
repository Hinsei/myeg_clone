defmodule Myeg.Services.Bureau do
  alias Myeg.Services.Bureau
  use Ecto.Schema
  import Ecto.Changeset

  @derive {
    Poison.Encoder,
    only: [
      :id,
      :name,
      :logo
    ]
  }

  schema "bureaus" do
    field :name, :string
    field :email, :string
    field :location, :string
    field :logo, :string
    field :mobile, :string
    field :type_of_specialties, {:array, :integer}, default: []
    has_many :specialties, Myeg.Services.Specialty
  end

  def changeset(struct = %Bureau{}, attrs \\ %{}) do
    struct
    |> cast(attrs, [:name, :email, :location, :logo, :mobile])
    |> validate_required([:name, :email, :location, :logo, :mobile])
  end

end
