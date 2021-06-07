defmodule GoogleCrawler.Search.Result do
  use Ecto.Schema
  # import Ecto.Changeset

  embedded_schema do
    field :all_ads, {:array, :string}
    field :html_code, :string
    field :links_count, :integer
    field :non_ads, {:array, :string}
    field :top_ads, {:array, :string}

    timestamps()
  end

  # @doc false
  # def changeset(result, attrs) do
  #   result
  #   |> cast(attrs, [:top_ads, :all_ads, :non_ads, :links_count, :html_code, :keyword])
  #   |> validate_required([:top_ads, :all_ads, :non_ads, :links_count, :html_code, :keyword])
  # end
end
