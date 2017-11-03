defmodule Myeg.Repo.Migrations.CreateSpecialty do
  use Ecto.Migration

  def up do
    create table(:specialty) do
      add :title, :string
      add :form_data, {:array, :map}, default: []
      add :bureau_id, references(:bureaus)

      timestamps()
    end
  end

  def down do
    drop table(:specialty)
  end
end
