defmodule GoogleCrawler.Search.Upload do
  # credo:disable-for-this-file Credo.Check.Consistency.MultiAliasImportRequireUse
  alias Ecto.Multi
  alias GoogleCrawler.Accounts.User
  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.{Keyword, KeywordWorker}

  @max_keywords 100

  def process(%User{} = user, %Plug.Upload{} = upload) do
    upload.path
    |> keyword_values()
    |> Enum.reduce(Multi.new(), fn name, multi ->
      multi
      |> Multi.insert(
        "keyword_#{name}",
        Keyword.changeset(%Keyword{}, %{name: String.trim(name), user: user})
      )
      |> Oban.insert("enqueue_search_#{name}", fn changes ->
        keyword_id = changes["keyword_#{name}"].id
        KeywordWorker.new(%{keyword_id: keyword_id})
      end)
    end)
    |> Repo.transaction()
  end

  defp keyword_values(upload_path) do
    upload_path
    |> File.stream!()
    |> CSV.decode!(seperator: ",")
    |> Enum.take(@max_keywords)
    |> List.flatten()
  end
end
