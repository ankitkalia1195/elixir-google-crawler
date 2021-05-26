defmodule GoogleCrawler.SearchTest do
  use GoogleCrawler.DataCase
  alias GoogleCrawler.Search
  alias GoogleCrawler.Search.Keyword

  describe "list_keywords" do
    test "lists the keywords for given user" do
      user = insert(:user)
      %{id: keyword_id} = insert(:keyword, name: "travel", user: user)

      assert [%Keyword{id: ^keyword_id}] = Search.list_keywords(user)
    end
  end
end
