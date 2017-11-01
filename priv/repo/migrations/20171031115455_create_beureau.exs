defmodule Myeg.Repo.Migrations.CreateBeureau do
  use Ecto.Migration

  def up do
    create table(:bureaus) do
      add :name, :string
      add :email, :string
      add :location, :string
      add :logo, :string
      add :mobile, :string
    end
  end

  def down do
    drop table(:bureaus)
  end
end
