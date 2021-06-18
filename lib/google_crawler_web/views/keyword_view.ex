defmodule GoogleCrawlerWeb.KeywordView do
  use GoogleCrawlerWeb, :view

  def links_count_select_options do
    ["" | Enum.to_list(1..100)]
  end
end
