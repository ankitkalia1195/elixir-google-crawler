defmodule GoogleCrawler.KeywordQueryTest do
  use GoogleCrawler.DataCase, async: true
  alias GoogleCrawler.Search.{Keyword, KeywordQuery, KeywordQueryParams, Result}

  describe "build_query/2" do
    test "lists the keywords for given user" do
      user = insert(:user)
      another_user = insert(:user)
      %{id: keyword_id} = insert(:keyword, name: "travel", user: user)
      insert(:keyword, name: "travel", user: another_user)

      assert [%Keyword{id: ^keyword_id}] = Repo.all(KeywordQuery.build(user, %KeywordQueryParams{}))
    end

    test "filters the keywords by links_count" do
      user = insert(:user)

      %{id: keyword_travel_id} =
        insert(:keyword, name: "travel", user: user, result: %Result{links_count: 2})

      %{id: keyword_thailand_id} =
        insert(:keyword, name: "thailand", user: user, result: %Result{links_count: 5})

      %{id: _keyword_australia_id} =
        insert(:keyword, name: "australia", user: user, result: %Result{links_count: 6})

      keyword_query_params = %KeywordQueryParams{min_links_count: 2, max_links_count: 5}

      assert [%Keyword{id: ^keyword_travel_id}, %Keyword{id: ^keyword_thailand_id}] =
               Repo.all(KeywordQuery.build(user, keyword_query_params))
    end

    test "filters the keywords by term" do
      user = insert(:user)

      %{id: keyword_england_id} =
        insert(:keyword, name: "england", user: user, result: %Result{links_count: 2})

      %{id: keyword_thailand_id} =
        insert(:keyword, name: "thailand", user: user, result: %Result{links_count: 5})

      %{id: _keyword_australia_id} =
        insert(:keyword, name: "australia", user: user, result: %Result{links_count: 6})

      keyword_query_params = %KeywordQueryParams{term: "lan"}

      assert [%Keyword{id: ^keyword_england_id}, %Keyword{id: ^keyword_thailand_id}] =
               Repo.all(KeywordQuery.build(user, keyword_query_params))
    end
  end
end
