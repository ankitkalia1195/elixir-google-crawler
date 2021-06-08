defmodule GoogleCrawler.Repo.Migrations.AddResultToKeywords do
  use Ecto.Migration

  def change do
    alter table(:keywords) do
      add :result, :map
    end
  end
end
