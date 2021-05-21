defmodule GoogleCrawlerWeb.UploadController do
  alias GoogleCrawler.Search.Upload
  use GoogleCrawlerWeb, :controller

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"upload" => upload}) do
    with {:ok, _changeset} <- Upload.process(conn.assigns[:current_user], upload["file"]) do
        conn
        |> put_flash(:info, "File processed successfully")
        |> redirect(to: Routes.upload_path(conn, :new))
    else
      _ ->
        conn
        |> put_flash(:error, "Some error occurred while processing the file")
        |> redirect(to: Routes.upload_path(conn, :new))
    end
  end
end
