defmodule GoogleCrawlerWeb.UploadFileTest do
  use GoogleCrawlerWeb.FeatureCase

  @selectors %{
    file_field: "upload[file]"
  }

  feature "uploads a file", %{session: session} do
    session
    |> login_with_user()
    |> visit(Routes.upload_path(GoogleCrawlerWeb.Endpoint, :new))
    |> attach_file(Query.file_field(@selectors.file_field),
      path: "test/support/fixtures/csv/valid.csv"
    )
    |> click(Query.button("Upload"))
    |> assert_has(Query.text("File processed successfully"))
    |> assert_has(css(".table"))
    |> assert_has(Query.text("travel"))
    |> assert_has(Query.text("thailand"))
  end
end
