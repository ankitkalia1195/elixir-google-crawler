defmodule GoogleCrawlerWeb.Api.KeywordControllerTest do
  use GoogleCrawlerWeb.ConnCase

  alias GoogleCrawler.Search.Result

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
