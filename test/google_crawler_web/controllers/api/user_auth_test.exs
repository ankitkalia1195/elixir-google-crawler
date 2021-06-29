defmodule GoogleCrawlerWeb.Api.UserAuthTest do
  use GoogleCrawlerWeb.ConnCase, async: true

  alias GoogleCrawlerWeb.Api.UserAuth

  describe "authenticate_user_by_token/2" do
    test "assigns the user to conn when VALID token is given", %{conn: conn} do
      user = insert(:user)
      token = insert(:user_token, context: "api", user: user)

      result_conn =
        conn
        |> put_req_header("x-token", Base.encode64(token.token))
        |> UserAuth.authenticate_user_by_token([])

      assert result_conn.assigns.current_user == token.user
    end

    test "halts the connection when INVALID token is given", %{conn: conn} do
      halted_conn =
        conn
        |> put_req_header("x-token", "invalid_token")
        |> UserAuth.authenticate_user_by_token([])

      assert halted_conn.halted
    end
  end
end
