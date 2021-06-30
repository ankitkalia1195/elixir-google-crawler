defmodule GoogleCrawler.Search.ParserTest do
  use GoogleCrawler.DataCase, async: true
  alias GoogleCrawler.Search.{GoogleClient, Parser, Result}

  describe "parse/1" do
    test "parses the html response" do
      use_cassette "search/keyword_hotels" do
        %{body: body} = GoogleClient.search("hotels")

        result = Parser.parse(body)

        top_ad_urls = ["https://www.hotels.com/", "https://www.booking.com/"]
        all_ad_urls = ["https://www.hotels.com/", "https://www.booking.com/"]

        non_ad_urls = [
          "https://www.hotels.com/",
          "https://www.booking.com/city/th/bangkok.html",
          "https://www.agoda.com/city/bangkok-th.html",
          "https://www.tripadvisor.com/Hotels-g293916-Bangkok-Hotels.html",
          "https://www.hotelscombined.com/Place/Bangkok.htm",
          "https://santorinidave.com/best-hotels-bangkok",
          "https://www.trip.com/hotels/bangkok-hotels-list-359/",
          "https://www.hotels2thailand.com/",
          "https://asq.in.th/",
          "https://www.expedia.co.th/en/Bangkok-Hotels.d178236.Travel-Guide-Hotels"
        ]

        assert %Result{
                 html_code: _,
                 links_count: 91,
                 all_ads: ^top_ad_urls,
                 non_ads: ^non_ad_urls,
                 top_ads: ^all_ad_urls
               } = result
      end
    end
  end
end
