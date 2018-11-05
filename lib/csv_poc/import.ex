defmodule Import do
  use Ecto.Schema

  alias CsvPoc.Repo

  import Ecto.Changeset

  schema "imports" do
    field :status, :string, default: "processing"

    timestamps()
  end

  def insert() do
    Repo.insert(changeset(%__MODULE__{}, %{status: "processing"}))
  end

  def changeset(schema, params) do
    cast(schema, params, [:status])
  end

  def update_status(schema, status) do
    Repo.update(changeset(schema, status))
  end
end
