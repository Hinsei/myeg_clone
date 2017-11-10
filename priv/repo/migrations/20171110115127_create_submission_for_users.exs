defmodule Myeg.Repo.Migrations.CreateSubmissionForUsers do
  use Ecto.Migration

  def up do
    create table(:submissions) do
      add :processed, :boolean, default: false
      add :user_id, references(:users)

      timestamps()
    end
  end

  def down do
    drop table(:submissions)
  end
end
