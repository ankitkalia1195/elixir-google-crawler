defmodule GoogleCrawler.Search.ParserTest do
  use GoogleCrawler.DataCase, async: true
  alias GoogleCrawler.Search.{Parser, Result}

  describe "parse/1" do
    test "parses the html response" do
      use_cassette "search/keyword_travel" do
        %{body: body} = HTTPoison.get!("https://www.google.com/search?q=travel")

        result = Parser.parse(body)

        non_ad_urls = [
          "/url?q=https://dict.longdo.com/search/travel&sa=U&ved=2ahUKEwjl2KHe2vXwAhVWRzABHXT8C-YQFjADegQICRAB&usg=AOvVaw0n5duBo5ucMSUadqH-fZgr",
          "/url?q=https://dict.longdo.com/search/*travel*&sa=U&ved=2ahUKEwjl2KHe2vXwAhVWRzABHXT8C-YQFjAEegQIChAB&usg=AOvVaw1Ox3nl1D-0hwRpMSbJdlxV",
          "/url?q=https://www.thaitravelcenter.com/th/&sa=U&ved=2ahUKEwjl2KHe2vXwAhVWRzABHXT8C-YQFjAFegQIBxAB&usg=AOvVaw36a2QmmrNrhMZqnTgUafcc",
          "/url?q=https://www.traveloka.com/th-th/&sa=U&ved=2ahUKEwjl2KHe2vXwAhVWRzABHXT8C-YQFjAGegQICBAB&usg=AOvVaw1WpSWSECPGMMjZOfij-lrZ",
          "/url?q=https://www.tourismthailand.org/home&sa=U&ved=2ahUKEwjl2KHe2vXwAhVWRzABHXT8C-YQFjAHegQIBhAB&usg=AOvVaw1NnwtDiwwZIHfrYxGxX4nY",
          "/url?q=https://travel.mthai.com/&sa=U&ved=2ahUKEwjl2KHe2vXwAhVWRzABHXT8C-YQFjAIegQIABAB&usg=AOvVaw1GzJnQlsqYcjJ2BNt3tYNB",
          "/url?q=https://www.sanook.com/travel/&sa=U&ved=2ahUKEwjl2KHe2vXwAhVWRzABHXT8C-YQFjAJegQIBBAB&usg=AOvVaw3xncv4ItKKKywBczTEH7S3",
          "/url?q=https://dictionary.sanook.com/search/dict-en-th-sedthabut/travel&sa=U&ved=2ahUKEwjl2KHe2vXwAhVWRzABHXT8C-YQFjAKegQIARAB&usg=AOvVaw1bCbhEgGxpOTTen41ITWLK",
          "/url?q=https://www.bangkokpost.com/travel/&sa=U&ved=2ahUKEwjl2KHe2vXwAhVWRzABHXT8C-YQFjALegQIAhAB&usg=AOvVaw25BT4bQn59-rsF5haX_7SW",
          "/url?q=https://jittawealth.com/thematic/TRAVEL-TECH&sa=U&ved=2ahUKEwjl2KHe2vXwAhVWRzABHXT8C-YQFjAMegQIAxAB&usg=AOvVaw2vFHiV3I5DkNVAT4B8yH7v"
        ]

        assert %Result{
                 html_code: _,
                 links_count: 49,
                 all_ads: [],
                 non_ads: ^non_ad_urls,
                 top_ads: []
               } = result
      end
    end
  end
end
