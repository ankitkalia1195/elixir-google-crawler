defmodule GoogleCrawler.Search.Upload do
  alias Ecto.Multi
  alias GoogleCrawler.Accounts.User
  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.Keyword

  @max_keywords 100

  def process(%User{} = user, %Plug.Upload{} = upload) do
    upload.path
    |> keyword_values()
    |> Enum.reduce(Multi.new(), fn name, multi ->
      Multi.insert(
        multi,
        {:keyword, name},
        Keyword.changeset(%Keyword{}, %{name: String.trim(name), user_id: user.id})
      )
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
