defmodule FakerCSV do
  alias Faker.Name.PtBr

  def generate_csv(entries) when is_integer(entries) do
    datas =
      Enum.map(1..entries, fn _ ->
        name = PtBr.first_name
        salary = :rand.uniform() * 3000 |> Float.round(2)

        [name, "#{salary}"]
      end)

    output = File.stream!("names.csv")

    CSV.encode(datas, separator: ?,)
    |>Stream.into(output)
    |> Stream.run()
  end
end
