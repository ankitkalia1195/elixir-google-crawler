defmodule GoogleCrawler.Accounts.Api.UserToken do
  alias GoogleCrawler.Accounts
  alias GoogleCrawler.Accounts.User
  alias GoogleCrawler.Accounts.UserToken, as: AccountsUserToken
  alias GoogleCrawler.Repo

  def authenticate_and_generate_token(email, password) do
    case Accounts.get_user_by_email_and_password(email, password) do
      %User{} = user ->
        {_token, user_token} = AccountsUserToken.build_api_token(user)
        {:ok, Repo.insert!(user_token)}

      _ ->
        {:error, :authentication_failed}
    end
  end
end
