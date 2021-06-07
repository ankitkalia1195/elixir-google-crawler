defmodule GoogleCrawler.Search.KeywordWorkerTest do
  use GoogleCrawler.DataCase, async: true
  alias GoogleCrawler.Search.KeywordWorker

  describe "perform" do
    test "creates the results" do
      use_cassette "search/keyword_travel" do
        user = insert(:user)
        keyword = insert(:keyword, name: "travel", user: user)

        KeywordWorker.perform(%Oban.Job{args: %{"keyword_id" => keyword.id}})

        result = Repo.reload(keyword).result

        assert result.all_ads == []
        assert result.top_ads == []
        assert result.links_count == 49
      end
    end

    test "updates the status of keyword" do
      use_cassette "search/keyword_travel" do
        user = insert(:user)
        keyword = insert(:keyword, name: "travel", user: user)

        KeywordWorker.perform(%Oban.Job{args: %{"keyword_id" => keyword.id}})
        reloaded_keyword = Repo.reload(keyword)

        assert reloaded_keyword.status == :finished
      end
    end
  end
end
