defmodule GoogleCrawler.Search.GoogleClient do
  @user_agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.447"
  @base_search_url "https://www.google.com/search"

  def search(keyword) do
    headers = ["User-Agent": @user_agent]

    HTTPoison.get!(keyword_search_url(keyword), headers)
  end

  defp keyword_search_url(keyword) do
    @base_search_url
    |> URI.parse()
    |> Map.put(:query, URI.encode_query(q: keyword, hl: "en", lr: "lang_on"))
    |> URI.to_string()
  end
end
