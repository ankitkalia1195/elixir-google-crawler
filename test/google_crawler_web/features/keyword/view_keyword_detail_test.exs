defmodule GoogleCrawlerWeb.Upload.ViewKeywordDetailPageTest do
  use GoogleCrawlerWeb.FeatureCase
  alias GoogleCrawler.Search.Result

  feature "views keyword detail page when keyword is processed", %{session: session} do
    user = insert(:user)

    result = %Result{
      links_count: 20,
      all_ads: ["www.hotels.com", "www.agoda.com"],
      non_ads: ["www.wikipedia.com"],
      top_ads: ["www.hotels.com"],
      html_code: ""
    }

    %{id: keyword_id} = insert(:keyword, name: "travel", user: user, result: result)

    session
    |> login(user.email, "hello world!")
    |> visit(Routes.keyword_path(GoogleCrawlerWeb.Endpoint, :show, keyword_id))
    |> assert_has(Query.text("travel"))
    |> assert_has(Query.text("Links Count"))
    |> assert_has(Query.text("Top Ad Urls"))
    |> assert_has(Query.text("All Ad Urls"))
    |> assert_has(css(".table"))
  end
end
