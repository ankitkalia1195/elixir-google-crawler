defmodule GoogleCrawlerWeb.Api.UserAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias GoogleCrawler.Accounts.UserToken
  alias GoogleCrawler.Repo

  def authenticate_user_by_token(conn, _opts) do
    header_token = conn |> get_req_header("x-token") |> List.first()

    case fetch_user_token(header_token) do
      %UserToken{} = user_token ->
        assign(conn, :current_user, user_token.user)

      _ ->
        conn
        |> put_status(401)
        |> put_view(GoogleCrawlerWeb.Api.ErrorView)
        |> render("show.json", %{message: "Invalid Token"})
        |> halt()
    end
  end

  defp fetch_user_token(header_token) do
    case Base.decode64(header_token) do
      {:ok, decoded_token} ->
        UserToken
        |> Repo.get_by(%{context: "api", token: decoded_token})
        |> Repo.preload(:user)

      _ ->
        :error
    end
  end
end
