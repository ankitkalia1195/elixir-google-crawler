defmodule GoogleCrawlerWeb.UploadController do
  use GoogleCrawlerWeb, :controller
  alias GoogleCrawler.Search.Upload

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"upload" => upload}) do
    case Upload.process(conn.assigns[:current_user], upload["file"]) do
      {:ok, _transaction_result} ->
        conn
        |> put_flash(:info, "File processed successfully")
        |> redirect(to: Routes.upload_path(conn, :new))

      _ ->
        conn
        |> put_flash(:error, "Some error occurred while processing the file")
        |> redirect(to: Routes.upload_path(conn, :new))
    end
  end
end
