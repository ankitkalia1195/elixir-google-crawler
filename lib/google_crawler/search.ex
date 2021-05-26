defmodule GoogleCrawler.Search do
  @moduledoc """
  The Search context.
  """
  import Ecto.Query, only: [from: 2]

  alias GoogleCrawler.Repo

  def list_keywords(user) do
    query = from(k in GoogleCrawler.Search.Keyword, where: k.user_id == ^user.id)

    Repo.all(query)
  end
end
