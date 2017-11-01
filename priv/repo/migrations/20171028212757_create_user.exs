defmodule Myeg.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def up do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string, null: false

      timestamps()
    end
  end

  def down do
    drop table(:users)
  end
end
