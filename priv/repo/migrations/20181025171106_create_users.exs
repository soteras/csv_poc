defmodule CsvPoc.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :salary, :decimal, default: 7000

      timestamps()
    end
  end
end
