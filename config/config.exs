# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :abq_show_finder,
  ecto_repos: [AbqShowFinder.Repo]

# Configures the endpoint
config :abq_show_finder, AbqShowFinderWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tCfJw5ta/cMuH+0fDJ2K5C03ZXDsHRF2OhvjcecCZZAht+73ATmSeYYTtHyX+5yH",
  render_errors: [view: AbqShowFinderWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AbqShowFinder.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
