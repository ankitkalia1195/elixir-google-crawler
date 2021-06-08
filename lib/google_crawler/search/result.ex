defmodule GoogleCrawler.Search.Result do
  use Ecto.Schema

  embedded_schema do
    field :all_ads, {:array, :string}
    field :html_code, :string
    field :links_count, :integer
    field :non_ads, {:array, :string}
    field :top_ads, {:array, :string}

    timestamps()
  end
end
