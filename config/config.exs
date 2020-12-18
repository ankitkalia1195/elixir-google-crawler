# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :google_crawler,
  ecto_repos: [GoogleCrawler.Repo]

# Configures the endpoint
config :google_crawler, GoogleCrawlerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QWQMdJ2lhOfiQ84G3ru+sQ/QxDnr04950xYP8AXajml7c6jYyLRh7bE6Pk0PrDrt",
  render_errors: [view: GoogleCrawlerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GoogleCrawler.PubSub,
  live_view: [signing_salt: "c7w5EK1+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
