defmodule GoogleCrawlerWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.Feature

      import GoogleCrawler.Factory

      alias GoogleCrawlerWeb.Router.Helpers, as: Routes
    end
  end
end
