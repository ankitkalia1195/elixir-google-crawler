defmodule GoogleCrawler.Search.GoogleClientTest do
  use GoogleCrawler.DataCase, async: true
  alias GoogleCrawler.Search.GoogleClient

  describe "search/1" do
    test "returns http response for given keyword" do
      use_cassette "search/keyword_hotels" do
        response = GoogleClient.search("hotels")

        assert %HTTPoison.Response{} = response
      end
    end
  end
end
