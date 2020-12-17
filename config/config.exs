# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_google_crawler,
  ecto_repos: [ElixirGoogleCrawler.Repo]

# Configures the endpoint
config :elixir_google_crawler, ElixirGoogleCrawlerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Bo1OT1wAYQwh8UPJgvau4G99r6bnGehnW/h0oVLYSS9p1i6Tvu4vYSVKbeBY7N5a",
  render_errors: [view: ElixirGoogleCrawlerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirGoogleCrawler.PubSub,
  live_view: [signing_salt: "o/5xtIlz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
