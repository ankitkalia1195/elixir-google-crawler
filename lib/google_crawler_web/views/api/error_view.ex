defmodule GoogleCrawlerWeb.Api.ErrorView do
  use GoogleCrawlerWeb, :view

  def render("show.json", %{message: message}) do
    %{
      errors: [
        %{
          detail: message
        }
      ]
    }
  end
end
