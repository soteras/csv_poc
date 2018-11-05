defmodule ErrorManager do
  def start do
    Process.register(
      spawn(fn -> loop() end),
      :error
    )
  end

  def loop do
    receive do
      {:save, {import_id, error}} ->
        case Error.insert(import_id, error) do
          {:ok, s} ->
            IO.inspect(s)
            loop()

          {:error, error} ->
            IO.inspect(error)
            loop()
        end
    end
  end
end
