defmodule GoogleCrawlerWeb.KeywordController do
  use GoogleCrawlerWeb, :controller

  alias GoogleCrawler.Search
  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.Keyword

  def index(conn, _params) do
    keywords = Search.list_keywords(conn.assigns[:current_user])
    render(conn, "index.html", keywords: keywords)
  end

  def show(conn, %{"id" => id}) do
    keyword = Repo.get_by(Keyword, %{id: id})
    render(conn, "show.html", keyword: keyword)
  end
end
