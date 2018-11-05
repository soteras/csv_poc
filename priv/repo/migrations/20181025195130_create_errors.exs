defmodule CsvPoc.Repo.Migrations.CreateErrors do
  use Ecto.Migration

  def change do
    create table(:errors) do
      add :error, :string
      add :import_id, references("imports")

      timestamps()
    end
  end
end
