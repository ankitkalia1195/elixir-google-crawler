defmodule GoogleCrawler.Search.UploadTest do
  use GoogleCrawler.DataCase
  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.Keyword
  import GoogleCrawler.AccountsFixtures

  describe "#process" do
    test "creates the keywords if file is successfully processed" do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/valid.csv", filename: "valid.csv"}
      user = user_fixture()

      GoogleCrawler.Search.Upload.process(user, upload)

      [first_keyword, second_keyword] = Repo.all(Keyword)
      assert first_keyword.name == "travel"
      assert second_keyword.name == "thailand"
    end

    test "does NOT create keywords when file cannot be processed" do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/invalid.csv", filename: "invalid.csv"}
      user = user_fixture()

      GoogleCrawler.Search.Upload.process(user, upload)

      assert [] = Repo.all(Keyword)
    end
  end
end
