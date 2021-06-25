defmodule GoogleCrawler.Api.Error do
  use Ecto.Schema

  embedded_schema do
    field :detail, :string
    field :source, :string
  end
end
