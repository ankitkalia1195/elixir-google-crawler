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
  secret_key_base: "nDw8ieOMCTqoqs7evqHKYcK6urKPbcBr06Ny6mKbe4TVD1AzCuq9bm2Q7j4eZ+3N",
  render_errors: [view: GoogleCrawlerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GoogleCrawler.PubSub,
  live_view: [signing_salt: "uJiqiewc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :google_crawler, Oban,
  repo: GoogleCrawler.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [default: 10]

config :jsonapi,
  host: System.get_env("HOST") || "localhost:4000",
  scheme: "http",
  namespace: "/api",
  field_transformation: :underscore,
  remove_links: false,
  json_library: Jason,
  paginator: nil

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
