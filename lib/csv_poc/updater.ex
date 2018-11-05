defmodule Updater do
  def start do
    Process.register(
      spawn(fn -> loop() end),
      :updater
    )
  end

  def loop do
    receive do
      {:save, {name, salary}} ->
        case User.insert_or_update(name, salary) do
          {:ok, user} ->
            loop()

          {:error, error} ->
            loop()
        end
    end
  end
end
