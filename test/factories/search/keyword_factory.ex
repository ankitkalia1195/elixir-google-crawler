defmodule GoogleCrawler.Search.KeywordFactory do
  defmacro __using__(_opts) do
    quote do
      def keyword_factory do
        %GoogleCrawler.Search.Keyword{}
      end
    end
  end
end
