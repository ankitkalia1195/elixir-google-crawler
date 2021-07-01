defmodule GoogleCrawler.Search.Parser do
  alias GoogleCrawler.Search.Result

  # TODO: Fix the selectors for gettings ad results, currently they are not correct.
  @selectors %{
    total_links: "a[href]",
    total_ads: ".Krnil",
    non_ads: ".yuRUbf > a",
    top_ads: "#tads .Krnil"
  }

  def parse(doc) do
    {:ok, document} = Floki.parse_document(doc)

    # TODO: Fix the html code parsing issue, as it results in a error while storing in database
    %Result{
      html_code: doc,
      links_count: total_links_count(document),
      all_ads: all_add_urls(document),
      non_ads: non_ad_urls(document),
      top_ads: top_ad_urls(document)
    }
  end

  defp total_links_count(document) do
    document |> Floki.find(@selectors.total_links) |> Enum.count()
  end

  defp all_add_urls(document) do
    document |> Floki.find(@selectors.total_ads) |> Floki.attribute("href")
  end

  defp non_ad_urls(document) do
    document |> Floki.find(@selectors.non_ads) |> Floki.attribute("href")
  end

  def top_ad_urls(document) do
    document |> Floki.find(@selectors.top_ads) |> Floki.attribute("href")
  end
end
