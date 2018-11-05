defmodule User do
  use Ecto.Schema

  alias CsvPoc.Repo

  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :salary, :decimal, default: 1000

    timestamps()
  end

  def changeset(schema, params) do
    cast(schema, params, [:id, :name, :salary])
  end

  def insert_or_update(name, salary) do
    schema =
      case find_by_name(name) do
        nil -> %__MODULE__{}
        user -> user
      end

    params = %{name: name, salary: salary}
    Repo.insert_or_update(changeset(schema, params))
  end

  @spec find_by_name(any()) :: any()
  def find_by_name(name) do
    Repo.get_by(__MODULE__, name: name)
  end
end
