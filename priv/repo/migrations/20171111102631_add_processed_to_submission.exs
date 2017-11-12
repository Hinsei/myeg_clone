defmodule Myeg.Repo.Migrations.AddProcessedToSubmission do
  use Ecto.Migration

  def up do
    alter table(:submissions) do
      add :processed, :boolean, default: false
    end
  end

  def down do
    alter table(:submissions) do
      remove :processed
    end
  end
end
