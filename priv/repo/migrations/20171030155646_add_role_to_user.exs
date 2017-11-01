defmodule Myeg.Repo.Migrations.AddRoleToUser do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :role, :integer, default: 0
    end
  end

  def down do
    alter table(:users) do
      remove :role
    end
  end
end
