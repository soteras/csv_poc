defmodule CsvPocWeb.PageController do
  use CsvPocWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
