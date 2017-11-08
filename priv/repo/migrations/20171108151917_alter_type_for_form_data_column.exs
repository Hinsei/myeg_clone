defmodule Myeg.Repo.Migrations.AlterTypeForFormDataColumn do
  use Ecto.Migration

  def up do
    alter table(:specialties) do
      remove :form_data
    end

    flush()

    alter table(:specialties) do
      add :form_data, {:array, :string}, default: []
    end
  end

  def down do
    alter table(:specialties) do
      remove :form_data
    end

    flush()

    alter table(:specialties) do
      add :form_data, {:array, :map}, default: []
    end
  end
end
