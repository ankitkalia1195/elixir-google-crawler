defmodule GoogleCrawler.Search.KeywordWorker do
  use Oban.Worker,
    priority: 1,
    max_attempts: 10,
    unique: [period: 30]

  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.{GoogleClient, Keyword, Parser}

  @impl Worker
  def perform(%Oban.Job{args: %{"keyword_id" => keyword_id}}) do
    keyword = Repo.get_by!(Keyword, %{id: keyword_id})

    updated_keyword =
      keyword
      |> Ecto.Changeset.change(status: :in_progress)
      |> Repo.update!()
      |> Ecto.Changeset.change(status: :finished)
      |> Ecto.Changeset.put_embed(:result, parsed_result!(keyword))
      |> Repo.update!()

    {:ok, updated_keyword}
  end

  defp parsed_result!(keyword) do
    response = GoogleClient.search(keyword.name)

    Parser.parse(response.body)
  end
end
