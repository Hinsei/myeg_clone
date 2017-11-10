defmodule Myeg.Repo.Migrations.LinkSubmissionToSpecialty do
  use Ecto.Migration

  def up do
    alter table(:submissions) do
      add :specialty_id, references(:specialties)
    end
  end

  def down do
    alter table(:submissions) do
      remove :specialty_id
    end
  end
end
