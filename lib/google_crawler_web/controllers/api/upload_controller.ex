defmodule GoogleCrawlerWeb.Api.UploadController do
  use GoogleCrawlerWeb, :controller
  alias GoogleCrawler.Search.Upload

  def create(conn, %{"upload" => upload}) do
    case Upload.process(conn.assigns[:current_user], upload["file"]) do
      {:ok, _transaction_result} ->
        conn
        |> put_view(GoogleCrawlerWeb.Api.SuccessView)
        |> put_status(201)
        |> render("show.json", %{message: "File Processed successfully"})

      _ ->
        conn
        |> put_view(GoogleCrawlerWeb.Api.ErrorView)
        |> put_status(422)
        |> render("show.json", %{message: "Some error occurred while processing the file"})
    end
  end
end
