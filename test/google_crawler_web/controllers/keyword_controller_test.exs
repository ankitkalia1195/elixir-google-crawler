defmodule GoogleCrawlerWeb.KeywordControllerTest do
  use GoogleCrawlerWeb.ConnCase

  alias GoogleCrawler.Repo

  describe "index" do
    test "assings keywords and returns 200 response", %{conn: conn} do
      user = insert(:user)
      keyword = insert(:keyword, name: "travel", status: :pending, user: user)

      result_conn =
        conn
        |> log_in_user(user)
        |> get(Routes.keyword_path(conn, :index))

      assert Repo.preload(result_conn.assigns[:keywords], :user) == [keyword]
      assert html_response(result_conn, 200) =~ "Listing Keywords"
    end
  end
end
