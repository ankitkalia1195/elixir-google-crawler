defmodule GoogleCrawler.Search.KeywordQuery do
  import Ecto.Query
  alias GoogleCrawler.Accounts.User
  alias GoogleCrawler.Search.{Keyword, KeywordQueryParams}

  def build(%User{} = user, %KeywordQueryParams{} = params) do
    Keyword
    |> where([k], k.user_id == ^user.id)
    |> filter_by_term(params)
    |> filter_by_links_count(params)
    |> order_by(desc: :inserted_at)
  end

  defp filter_by_term(query, %KeywordQueryParams{term: term}) when term != "" do
    query_term = "%#{term}%"
    where(query, [k], like(k.name, ^query_term))
  end

  defp filter_by_term(query, _) do
    where(query, true)
  end

  defp filter_by_links_count(query, %KeywordQueryParams{
         min_links_count: min_links_count,
         max_links_count: max_links_count
       })
       when min_links_count != nil or max_links_count != nil do
    where(
      query,
      [k],
      fragment(
        "(?->>'links_count')::INTEGER BETWEEN ? AND ?",
        k.result,
        ^min_links_count,
        ^max_links_count
      )
    )
  end

  defp filter_by_links_count(query, _) do
    where(query, true)
  end
end
