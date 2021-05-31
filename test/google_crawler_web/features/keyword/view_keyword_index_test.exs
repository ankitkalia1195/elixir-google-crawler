defmodule GoogleCrawlerWeb.Upload.ViewKeywordIndexPageTest do
  use GoogleCrawlerWeb.FeatureCase

  feature "views keyword index page", %{session: session} do
    user = insert(:user)
    insert(:keyword, name: "travel", user: user)

    session
    |> login(user.email, "hello world!")
    |> visit(Routes.keyword_path(GoogleCrawlerWeb.Endpoint, :index))
    |> assert_has(Query.text("Listing Keywords"))
    |> assert_has(css(".table"))
    |> assert_has(Query.text("travel"))
  end
end
