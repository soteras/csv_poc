defmodule CsvPoc.Repo.Migrations.CreateImports do
  use Ecto.Migration

  def change do
    create table(:imports) do
      add :status, :string, default: "processing"

      timestamps()
    end
  end
end
