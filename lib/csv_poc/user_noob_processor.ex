defmodule UserNoobProcessor do
  alias CsvPoc.Repo

  def process(import_id, datas) do
    changesets =
      Enum.map(datas, fn {:ok, data} ->
        [name, salary] = data

        case Float.parse(salary) do
          :error ->
            error = "name: #{name}, salary: #{salary}. cannot be coerced into a valid float"
            Error.insert(import_id, error)

          {salary, _} ->
            %{name: name, salary: salary, inserted_at: DateTime.utc_now(), updated_at: DateTime.utc_now()}
        end
      end)

    Repo.insert_all(User, changesets)
  end
end
