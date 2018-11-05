defmodule CsvPoc do
  alias CsvPoc.Repo

  import Ecto.Query, only: [from: 2]

  def start() do
    Updater.start()
    ErrorManager.start()
  end

  def parse(file_path \\ "names.csv") do
    File.stream!(file_path)
    |> CSV.decode(separator: ?,)
  end

  def print_names() do
    users = Repo.all(User)

    Enum.each(users, fn user ->
      IO.inspect("#{user.name} - #{user.salary}")
    end)
  end

  def count_users() do
    Repo.aggregate(User, :count, :id)
  end

  def reset() do
    Repo.delete_all(Error)
    Repo.delete_all(Import)
    Repo.delete_all(User)
  end

  def errors() do
    Repo.all(Error)
  end

  def do_all(type \\ :multi) do
    try do
      start()
    rescue
      ArgumentError -> "Error"
    end

    reset()
    datas = parse()

    case Import.insert do
      {:ok, import_schema} ->
        case type do
          :multi ->
            Enum.map(datas, fn {:ok, data} ->
              spawn(UserProcessor, :process, [import_schema.id, data])
            end)

            IO.inspect "MULTI", label: ".......MULTI"

          :single ->
            UserNoobProcessor.process(import_schema.id, datas)
            IO.inspect "SINGLE", label: ".......SINGLE"
        end

      {:error, error} ->
        error
    end
  end
end
