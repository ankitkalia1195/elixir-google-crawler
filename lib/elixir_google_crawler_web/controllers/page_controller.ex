defmodule ElixirGoogleCrawlerWeb.PageController do
  use ElixirGoogleCrawlerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
