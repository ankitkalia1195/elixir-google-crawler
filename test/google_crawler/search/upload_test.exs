defmodule GoogleCrawler.Search.UploadTest do
  use GoogleCrawler.DataCase
  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.Keyword

  describe "#process/2" do
    test "creates the keywords if file is successfully processed" do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/valid.csv", filename: "valid.csv"}
      user = insert(:user)

      result = GoogleCrawler.Search.Upload.process(user, upload)

      assert {:ok,
              %{
                "enqueue_search_ thailand" => %Oban.Job{},
                "enqueue_search_travel" => %Oban.Job{},
                "keyword_ thailand" => %Keyword{},
                "keyword_travel" => %Keyword{}
              }} = result

      [first_keyword, second_keyword] = Repo.all(Keyword)
      assert first_keyword.name == "travel"
      assert second_keyword.name == "thailand"
    end

    test "does NOT create keywords when file cannot be processed" do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/invalid.csv", filename: "invalid.csv"}
      user = insert(:user)

      result = GoogleCrawler.Search.Upload.process(user, upload)

      assert {:error, "keyword_", _changeset, %{}} = result

      assert Repo.aggregate(Keyword, :count) == 0
    end
  end
end
