# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :csv_poc,
  ecto_repos: [CsvPoc.Repo]

# Configures the endpoint
config :csv_poc, CsvPocWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1I9yut9x32vegcK7zbHA+qLRJTKLX7tTEA/S9DY5uD5n67Pc2rsTMSQ2iFRusGs4",
  render_errors: [view: CsvPocWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CsvPoc.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
