defmodule GoogleCrawlerWeb.Api.KeywordControllerTest do
  use GoogleCrawlerWeb.ConnCase

  alias GoogleCrawler.Search.{Keyword, Result}

  describe "GET index/2" do
    test "assigns keywords and returns 200 response", %{conn: conn} do
      user = insert(:user)
      token = insert(:user_token, user: user, context: "api")
      %{id: keyword_id} = insert(:keyword, name: "travel", status: :pending, user: user)

      result_conn =
        conn
        |> log_in_user(user)
        |> put_req_header("x-token", Base.encode64(token.token))
        |> get(Routes.api_keyword_path(conn, :index))

      assert [%Keyword{id: ^keyword_id}] = result_conn.assigns[:data]

      assert json_response(result_conn, 200) == %{
               "data" => [
                 %{
                   "attributes" => %{"name" => "travel", "result" => nil},
                   "id" => "#{keyword_id}",
                   "links" => %{"self" => "http://localhost:4000/api/keyword/#{keyword_id}"},
                   "relationships" => %{},
                   "type" => "keyword"
                 }
               ],
               "included" => [],
               "links" => %{"self" => "http://localhost:4000/api/keyword"}
             }
    end

    test "filters the keywords by min_links_count and max_links_count", %{conn: conn} do
      user = insert(:user)
      token = insert(:user_token, user: user, context: "api")
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
        |> put_req_header("x-token", Base.encode64(token.token))
        |> get(Routes.api_keyword_path(conn, :index), %{
          "filter" => %{"min_links_count" => 2, "max_links_count" => 4}
        })

      assert [%Keyword{id: ^keyword_travel_id}, %Keyword{id: ^keyword_thailand_id}] =
               result_conn.assigns[:data]
    end

    test "filters the keywords by term", %{conn: conn} do
      user = insert(:user)
      token = insert(:user_token, user: user, context: "api")
      %{id: keyword_england_id} = insert(:keyword, name: "england", user: user)
      %{id: keyword_thailand_id} = insert(:keyword, name: "thailand", user: user)
      %{id: _keyword_australia_id} = insert(:keyword, name: "australia", user: user)

      result_conn =
        conn
        |> log_in_user(user)
        |> put_req_header("x-token", Base.encode64(token.token))
        |> get(Routes.api_keyword_path(conn, :index), %{"filter" => %{"term" => "lan"}})

      assert [%Keyword{id: ^keyword_england_id}, %Keyword{id: ^keyword_thailand_id}] =
               result_conn.assigns[:data]
    end
  end

  describe "show/2" do
    test "returns keyword details when valid keyword_id is given", %{conn: conn} do
      user = insert(:user)
      token = insert(:user_token, user: user, context: "api")
      keyword = insert(:keyword, name: "travel", user: user)

      result_conn =
        conn
        |> put_req_header("x-token", Base.encode64(token.token))
        |> get(Routes.api_keyword_path(conn, :show, keyword))

      assert json_response(result_conn, 200) == %{
               "data" => %{
                 "attributes" => %{"name" => "travel", "result" => nil},
                 "id" => Integer.to_string(keyword.id),
                 "links" => %{"self" => "http://localhost:4000/api/keyword/#{keyword.id}"},
                 "relationships" => %{},
                 "type" => "keyword"
               },
               "included" => [],
               "links" => %{"self" => "http://localhost:4000/api/keyword/#{keyword.id}"}
             }
    end

    test "returns keyword_details with result when valid keyword_id is given", %{conn: conn} do
      user = insert(:user)

      result = %Result{
        non_ads: [],
        all_ads: [],
        top_ads: [],
        links_count: 50,
        html_code: nil
      }

      token = insert(:user_token, user: user, context: "api")
      keyword = insert(:keyword, name: "travel", user: user, result: result)

      result_conn =
        conn
        |> put_req_header("x-token", Base.encode64(token.token))
        |> get(Routes.api_keyword_path(conn, :show, keyword))

      assert json_response(result_conn, 200) == %{
               "data" => %{
                 "attributes" => %{
                   "name" => "travel",
                   "result" => %{
                     "all_ads" => [],
                     "html_code" => nil,
                     "links_count" => 50,
                     "non_ads" => [],
                     "top_ads" => []
                   }
                 },
                 "id" => Integer.to_string(keyword.id),
                 "links" => %{"self" => "http://localhost:4000/api/keyword/#{keyword.id}"},
                 "relationships" => %{},
                 "type" => "keyword"
               },
               "included" => [],
               "links" => %{"self" => "http://localhost:4000/api/keyword/#{keyword.id}"}
             }
    end

    test "returns not_found when keyword_id not belonging to user given", %{conn: conn} do
      user = insert(:user)
      another_user = insert(:user)
      token = insert(:user_token, user: user, context: "api")
      keyword = insert(:keyword, name: "travel", user: another_user)

      result_conn =
        conn
        |> put_req_header("x-token", Base.encode64(token.token))
        |> get(Routes.api_keyword_path(conn, :show, keyword))

      assert json_response(result_conn, 404) == %{"errors" => [%{"detail" => "Not Found"}]}
    end
  end
end
