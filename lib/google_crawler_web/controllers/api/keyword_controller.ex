defmodule GoogleCrawlerWeb.Api.KeywordController do
  use GoogleCrawlerWeb, :controller

  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.Keyword

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
