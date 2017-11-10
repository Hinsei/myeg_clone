defmodule Myeg.Repo.Migrations.AddFormInputToSubmissions do
  use Ecto.Migration

  def up do
    alter table(:submissions) do
      add :form_input, :map, default: %{}
    end
  end

  def down do
    alter table(:submissions) do
      remove :form_input
    end
  end
end
