defmodule GoogleCrawlerWeb.KeywordControllerTest do
  use GoogleCrawlerWeb.ConnCase, async: true

  alias GoogleCrawler.Search.{Keyword, Result}

  describe "GET index/2" do
    test "assigns keywords and returns 200 response", %{conn: conn} do
      user = insert(:user)
      %{id: keyword_id} = insert(:keyword, name: "travel", status: :pending, user: user)

      result_conn =
        conn
        |> log_in_user(user)
        |> get(Routes.keyword_path(conn, :index))

      assert [%Keyword{id: ^keyword_id}] = result_conn.assigns[:keywords]
      assert html_response(result_conn, 200) =~ "travel"
    end

    test "filters the keywords by min_links_count and max_links_count", %{conn: conn} do
      user = insert(:user)
      result = %Result{all_ads: [], top_ads: [], non_ads: [], links_count: 2}

      %{id: keyword_travel_id} =
        insert(:keyword, name: "travel", user: user, result: Map.merge(result, %{links_count: 2}))

      %{id: keyword_thailand_id} =
        insert(:keyword, name: "thailand", user: user, result: Map.merge(result, %{links_count: 4}))

      %{id: _keyword_australia_id} =
        insert(:keyword, name: "australia", user: user, result: Map.merge(result, %{links_count: 6}))

      result_conn =
        conn
        |> log_in_user(user)
        |> get(Routes.keyword_path(conn, :index), %{
          "filter" => %{"min_links_count" => 2, "max_links_count" => 4}
        })

      assert [%Keyword{id: ^keyword_travel_id}, %Keyword{id: ^keyword_thailand_id}] =
               result_conn.assigns[:keywords]
    end

    test "filters the keywords by term", %{conn: conn} do
      user = insert(:user)
      %{id: keyword_england_id} = insert(:keyword, name: "england", user: user)
      %{id: keyword_thailand_id} = insert(:keyword, name: "thailand", user: user)
      %{id: _keyword_australia_id} = insert(:keyword, name: "australia", user: user)

      result_conn =
        conn
        |> log_in_user(user)
        |> get(Routes.keyword_path(conn, :index), %{"filter" => %{"term" => "lan"}})

      assert [%Keyword{id: ^keyword_england_id}, %Keyword{id: ^keyword_thailand_id}] =
               result_conn.assigns[:keywords]
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

    test "redirects to index when keyword is not found", %{conn: conn} do
      user = insert(:user)
      another_user = insert(:user)
      %{id: keyword_id} = insert(:keyword, name: "travel", status: :pending, user: another_user)

      result_conn =
        conn
        |> log_in_user(user)
        |> get(Routes.keyword_path(conn, :show, keyword_id))

      assert redirected_to(result_conn) == Routes.keyword_path(conn, :index)
      assert get_flash(result_conn, :error) == "Keyword not found"
    end
  end
end
