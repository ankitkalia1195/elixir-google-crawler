defmodule ElixirGoogleCrawler.Repo do
  use Ecto.Repo,
    otp_app: :elixir_google_crawler,
    adapter: Ecto.Adapters.Postgres
end
