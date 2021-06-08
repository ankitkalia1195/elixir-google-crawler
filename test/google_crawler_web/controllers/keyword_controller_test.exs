defmodule GoogleCrawlerWeb.KeywordControllerTest do
  use GoogleCrawlerWeb.ConnCase, async: true

  alias GoogleCrawler.Search.Keyword

  describe "GET index/2" do
    test "assigns keywords and returns 200 response", %{conn: conn} do
      user = insert(:user)
      %{id: keyword_id} = insert(:keyword, name: "travel", status: :pending, user: user)

      result_conn =
        conn
        |> log_in_user(user)
        |> get(Routes.keyword_path(conn, :index))

      assert [%Keyword{id: ^keyword_id}] = result_conn.assigns[:keywords]
      assert html_response(result_conn, 200) =~ "Listing Keywords"
    end
  end

  describe "GET show/2" do
    test "assigns keyword and returns 200 response", %{conn: conn} do
      user = insert(:user)
      %{id: keyword_id} = insert(:keyword, name: "travel", status: :pending, user: user)

      result_conn =
        conn
        |> log_in_user(user)
        |> get(Routes.keyword_path(conn, :show, keyword_id))

      assert %Keyword{id: ^keyword_id} = result_conn.assigns[:keyword]
      assert html_response(result_conn, 200) =~ "travel"
    end
  end
end
