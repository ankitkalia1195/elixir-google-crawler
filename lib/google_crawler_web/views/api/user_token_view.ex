defmodule GoogleCrawlerWeb.Api.UserTokenView do
  use JSONAPI.View, type: "user_token"

  use GoogleCrawlerWeb, :view

  def fields do
    [:id, :access_token]
  end

  def access_token(token, _con) do
    Base.encode64(token.token)
  end
end
