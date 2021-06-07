defmodule GoogleCrawler.Search.Keyword do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoogleCrawler.Accounts.User
  alias GoogleCrawler.Search.Result

  schema "keywords" do
    field :name, :string
    field :status, Ecto.Enum, values: [pending: 0, in_progress: 1, failed: 2, finished: 3]
    belongs_to :user, User
    embeds_one :result, Result

    timestamps()
  end

  def changeset(keyword, attrs) do
    keyword
    |> cast(attrs, [:name])
    |> put_assoc(:user, attrs[:user])
    |> validate_required([:name, :user])
  end
end
