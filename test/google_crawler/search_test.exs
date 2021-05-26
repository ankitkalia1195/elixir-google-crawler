defmodule GoogleCrawler.SearchTest do
  use GoogleCrawler.DataCase, async: true
  alias GoogleCrawler.Search
  alias GoogleCrawler.Search.Keyword

  describe "list_keywords/2" do
    test "lists the keywords for given user" do
      user = insert(:user)
      %{id: keyword_id} = insert(:keyword, name: "travel", user: user)

      assert [%Keyword{id: ^keyword_id}] = Search.list_keywords(user)
    end
  end
end
