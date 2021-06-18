defmodule GoogleCrawler.Search.KeywordQueryParams do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :term, :string
    field :min_links_count, :integer
    field :max_links_count, :integer
  end

  def new(params) do
    changeset = %__MODULE__{}
              |> changeset(params)

    %{query_params: Ecto.Changeset.apply_changes(changeset), changeset: changeset }
  end

  def changeset(keyword_query_params  \\ %__MODULE__{}, attrs) do
    cast(keyword_query_params, attrs, [:term, :min_links_count, :max_links_count])
  end
end
