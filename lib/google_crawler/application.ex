defmodule GoogleCrawler.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      GoogleCrawler.Repo,
      # Start the Telemetry supervisor
      GoogleCrawlerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GoogleCrawler.PubSub},
      # Start the Endpoint (http/https)
      GoogleCrawlerWeb.Endpoint,
      {Oban, oban_config()}
      # Start a worker by calling: GoogleCrawler.Worker.start_link(arg)
      # {GoogleCrawler.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GoogleCrawler.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GoogleCrawlerWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # Conditionally disable crontab, queues, or plugins here.
  defp oban_config do
    Application.get_env(:google_crawler, Oban)
  end
end
