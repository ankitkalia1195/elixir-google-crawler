defmodule GoogleCrawlerWeb.KeywordController do
  use GoogleCrawlerWeb, :controller

  alias GoogleCrawler.Search

  def index(conn, _params) do
    keywords = Search.list_keywords(conn.assigns[:current_user])
    render(conn, "index.html", keywords: keywords)
  end
end
