defmodule GoogleCrawlerWeb.HomePage.ViewHomePageTest do
  use GoogleCrawlerWeb.FeatureCase

  feature "view home page", %{session: session} do
    visit(session, Routes.page_path(GoogleCrawlerWeb.Endpoint, :index))

    assert_has(session, Query.text("Welcome to Phoenix!"))
  end
end
