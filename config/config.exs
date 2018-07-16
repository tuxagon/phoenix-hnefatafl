# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hnefatafl,
  ecto_repos: [Hnefatafl.Repo]

# Configures the endpoint
config :hnefatafl, HnefataflWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+7/F+4xny/3a1JhCJIoHqVocBEl8vOkUAM5lH2HDHyq7/ilC/6Yb+0gK79KOzDyO",
  render_errors: [view: HnefataflWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hnefatafl.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
