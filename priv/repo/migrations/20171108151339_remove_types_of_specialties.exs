defmodule Myeg.Repo.Migrations.RemoveTypesOfSpecialties do
  use Ecto.Migration

  def up do
    alter table(:bureaus) do
      remove :type_of_specialties
    end
  end
  
  def down do
    alter table(:bureaus) do
      add :type_of_specialties, {:array, :integer}, default: []
    end
  end
end
