defmodule GoogleCrawlerWeb.Api.PageControllerTest do
  use GoogleCrawlerWeb.ConnCase

  describe "POST create/2" do
    test "returns the token when VALID credentials are given", %{conn: conn} do
      insert(:user, email: "test@example.com", password: "valid_password")

      result_conn =
        conn
        |> put_req_header("content-type", "application/vnd.api+json")
        |> put_req_header("accept", "application/vnd.api+json")
        |> post(Routes.token_path(conn, :create), %{
          "data" => %{
            "attributes" => %{"email" => "test@example.com", password: "valid_password"},
            "type" => "credentials"
          }
        })

      assert %{
               "data" => %{
                 "attributes" => %{"access_token" => _, "id" => _},
                 "id" => _,
                 "links" => %{"self" => _},
                 "relationships" => %{},
                 "type" => "user_token"
               },
               "included" => [],
               "links" => %{"self" => _}
             } = json_response(result_conn, 200)
    end

    test "returns error when INVALID credentials are given", %{conn: conn} do
      insert(:user, email: "test@example.com", password: "valid_password")

      result_conn =
        conn
        |> put_req_header("content-type", "application/vnd.api+json")
        |> put_req_header("accept", "application/vnd.api+json")
        |> post(Routes.token_path(conn, :create), %{
          "data" => %{
            "attributes" => %{"email" => "test@example.com", password: "invalid_password"},
            "type" => "credentials"
          }
        })

      assert json_response(result_conn, 422) == %{
               "errors" => [%{"detail" => "Invalid Credentials"}]
             }
    end
  end
end
