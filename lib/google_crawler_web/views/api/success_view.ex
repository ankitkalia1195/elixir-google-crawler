defmodule GoogleCrawlerWeb.Api.SuccessView do
  use GoogleCrawlerWeb, :view

  def render("show.json", %{message: message}) do
    %{
      meta: [
        %{
          detail: message
        }
      ]
    }
  end
end
