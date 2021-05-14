defmodule GoogleCrawlerWeb.PageControllerTest do
  use GoogleCrawlerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Google Crawler!"
  end
end
