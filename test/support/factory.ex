defmodule GoogleCrawler.Factory do
  use ExMachina.Ecto, repo: GoogleCrawler.Repo

  use GoogleCrawler.Accounts.UserFactory

  # Define your factories in /test/factories and declare it here,
  # eg: `use GoogleCrawler.Accounts.UserFactory`
end
