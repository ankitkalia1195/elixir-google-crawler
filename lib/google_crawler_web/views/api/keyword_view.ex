defmodule GoogleCrawlerWeb.Api.KeywordView do
  use JSONAPI.View, type: "keyword"
  alias GoogleCrawler.Search.Result

  def fields do
    [:id, :name, :result]
  end

  def result(keyword, _conn) do
    case keyword.result do
      %Result{} ->
        Map.from_struct(keyword.result)

      _ ->
        nil
    end
  end
end
