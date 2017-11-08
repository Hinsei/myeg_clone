defmodule Myeg.Services.Specialty do
  use Ecto.Schema
  import Ecto.Changeset

  schema "specialties" do
    field :title, :string
    field :form_data, {:array, :map}, default: []
    field :type, Myeg.Enum.TypeOfService
    belongs_to :bureau, Myeg.Services.Bureau

    timestamps()
  end

  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:title, :form_data, :bureau_id])
    |> validate_required([:title, :form_data, :bureau_id])
  end
end
