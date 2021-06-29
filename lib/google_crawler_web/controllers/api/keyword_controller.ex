defmodule GoogleCrawlerWeb.Api.KeywordController do
  use GoogleCrawlerWeb, :controller

  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search
  alias GoogleCrawler.Search.Keyword
  alias GoogleCrawler.Search.{Keyword, KeywordQueryParams}

  def index(conn, params) do
    %{query_params: query_params, changeset: _changeset} =
      KeywordQueryParams.new(params["filter"] || %{})

    keywords = Search.list_keywords(conn.assigns[:current_user], query_params)
    render(conn, "index.json", data: keywords)
  end

  def show(conn, %{"id" => id}) do
    keyword = Repo.get_by(Keyword, %{id: id, user_id: conn.assigns[:current_user].id})

    case keyword do
      %Keyword{} = keyword ->
        render(conn, "show.json", data: keyword)

      _ ->
        conn
        |> put_view(GoogleCrawlerWeb.Api.ErrorView)
        |> put_status(404)
        |> render("show.json", %{message: "Not Found"})
    end
  end
end
