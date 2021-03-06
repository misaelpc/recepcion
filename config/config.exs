# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :reception, Reception.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "H3GMtn+QWkKYdKO2Br8Xgb4USd5Lz6QprgelqH6n/OnHeXsYQ0c1hGiqm9QHgDNE",
  debug_errors: false,
  pubsub: [adapter: Phoenix.PubSub.PG2]

config :reception, Reception.Repo,
  database: "recepcion",
  username: "hiphoox",
  password: "",
  hostname: "localhost"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

