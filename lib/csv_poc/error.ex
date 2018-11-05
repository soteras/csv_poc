defmodule Error do
  use Ecto.Schema

  alias CsvPoc.Repo

  import Ecto.Changeset

  schema "errors" do
    field :error, :string

    belongs_to :import, Import

    timestamps()
  end

  def changeset(schema, params) do
    cast(schema, params, [:import_id, :error])
  end

  def insert(import_id, error) do
    params = %{import_id: import_id, error: error}
    Repo.insert(changeset(%__MODULE__{}, params))
  end

  def find_by_import_id(import_id) do
    Repo.get_by(__MODULE__, import_id: import_id)
  end
end
