defmodule Myeg.Accounts.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "submissions" do
    field :processed, :boolean, default: false
    belongs_to :user, Myeg.Accounts.User
    belongs_to :specialty, Myeg.Services.Specialty

    timestamps()
  end


  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:processed, :user_id])
    |> validate_required([:user_id])
  end

end
