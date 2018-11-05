defmodule UserProcessor do
  def process(import_id, data) do
    [name, salary] = data

    case Float.parse(salary) do
      :error ->
        error = "name: #{name}, salary: #{salary}. cannot be coerced into a valid float"
        send(:error, {:save, {import_id, error}})
        exit(:seems_bad)

      {salary, _} ->
        send(:updater, {:save, {name, salary}})
        exit(:normal)
    end
  end
end
