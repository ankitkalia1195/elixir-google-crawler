defmodule GoogleCrawler.Search.Upload do
  alias GoogleCrawler.Accounts.User
  alias GoogleCrawler.Search.Keyword
  alias GoogleCrawler.Repo
  alias Ecto.Multi

  def process(%User{} = user, %Plug.Upload{} = upload) do
    keyword_values(upload.path)
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
    File.stream!(upload_path)
    |> CSV.decode!(seperator: ",")
    |> Enum.take(100)
    |> List.flatten()
  end
end
