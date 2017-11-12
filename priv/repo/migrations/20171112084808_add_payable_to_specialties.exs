defmodule Myeg.Repo.Migrations.AddPayableToSpecialties do
  use Ecto.Migration

  def up do
    alter table(:specialties) do
      add :payable, :boolean, default: false
    end
  end

  def down do
    alter table(:specialties) do
      remove :payable
    end
  end
end
