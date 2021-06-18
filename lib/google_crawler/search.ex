defmodule GoogleCrawler.Search do
  @moduledoc """
  The Search context.
  """

  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.{KeywordQuery, KeywordQueryParams}

  def list_keywords(user, query_params \\ %KeywordQueryParams{}) do
    query = KeywordQuery.build(user, query_params)
    Repo.all(query)
  end
end
