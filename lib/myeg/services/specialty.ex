defmodule Myeg.Services.Specialty do
  use Ecto.Schema
  import Ecto.Changeset

  schema "specialty" do
    field :title, :string
    field :form_data, {:array, :map}, default: []
    belongs_to :bureau, Myeg.Services.Bureua

    timestamps()
  end

  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:title, :form_data, :bureau_id])
    |> validate_required([:title, :form_data, :bureau_id])
  end
end
