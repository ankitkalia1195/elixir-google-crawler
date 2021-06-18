defmodule GoogleCrawler.Search do

  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.{KeywordQuery, KeywordQueryParams}
  @moduledoc """
  The Search context.
  """
  def list_keywords(user, query_params \\ %KeywordQueryParams{}) do
    query = KeywordQuery.build(user, query_params)
    Repo.all(query)
  end
end
