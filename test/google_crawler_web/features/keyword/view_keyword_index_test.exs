defmodule GoogleCrawlerWeb.Upload.ViewKeywordIndexPageTest do
  use GoogleCrawlerWeb.FeatureCase
  alias GoogleCrawler.Search.Result

  feature "views keyword index page", %{session: session} do
    user = insert(:user)
    insert(:keyword, name: "travel", user: user)

    session
    |> login(user.email, "hello world!")
    |> visit(Routes.keyword_path(GoogleCrawlerWeb.Endpoint, :index))
    |> assert_has(css(".table"))
    |> assert_has(Query.text("travel"))
  end

  feature "filters keyword", %{session: session} do
    user = insert(:user)
    result = %Result{all_ads: [], top_ads: [], non_ads: [], links_count: 2}
    insert(:keyword, name: "england", user: user, result: Map.merge(result, %{links_count: 2}))
    insert(:keyword, name: "thailand", user: user, result: Map.merge(result, %{links_count: 4}))
    insert(:keyword, name: "australia", user: user, result: Map.merge(result, %{links_count: 6}))

    session
    |> login(user.email, "hello world!")
    |> visit(Routes.keyword_path(GoogleCrawlerWeb.Endpoint, :index))
    |> fill_in(Wallaby.Query.text_field("filter[term]"), with: "lan")
    |> click(Wallaby.Query.button("Filter"))
    |> assert_has(css(".table"))
    |> assert_has(Query.text("thailand"))
    |> assert_has(Query.text("england"))
    |> refute_has(Query.text("australia"))
  end
end
