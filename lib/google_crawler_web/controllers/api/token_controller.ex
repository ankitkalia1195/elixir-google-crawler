defmodule GoogleCrawlerWeb.Api.TokenController do
  use GoogleCrawlerWeb, :controller

  alias GoogleCrawler.Accounts
  alias GoogleCrawler.Repo

  def create(conn, %{"data" => %{"attributes" => %{"email" => email, "password" => password}}}) do
    case Accounts.authenticate_and_generate_api_token(email, password) do
      {:ok, token} ->
        conn
        |> put_view(GoogleCrawlerWeb.Api.UserTokenView)
        |> render("show.json", data: token)

      _ ->
        conn
        |> put_view(GoogleCrawlerWeb.Api.ErrorView)
        |> put_status(422)
        |> render("show.json", %{message: "Invalid Credentials"})
    end
  end
end
