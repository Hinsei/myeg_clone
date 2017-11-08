defmodule Myeg.Repo.Migrations.AddTypeToSpecialty do
  use Ecto.Migration

  def up do
    alter table(:specialties) do
      add :type, :integer
    end
  end

  def down do
    alter table(:specialties) do
      remove :type
    end
  end
end
