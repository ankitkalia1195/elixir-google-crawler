defmodule GoogleCrawlerWeb.KeywordController do
  use GoogleCrawlerWeb, :controller

  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search
  alias GoogleCrawler.Search.{Keyword, KeywordQueryParams}

  def index(conn, params) do
    %{query_params: query_params, changeset: changeset} =
      KeywordQueryParams.new(params["filter"] || %{})

    keywords = Search.list_keywords(conn.assigns[:current_user], query_params)
    render(conn, "index.html", keywords: keywords, query_params_changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    keyword = Repo.get_by(Keyword, %{id: id})
    render(conn, "show.html", keyword: keyword)
  end
end
