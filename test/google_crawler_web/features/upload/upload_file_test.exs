defmodule GoogleCrawlerWeb.UploadFileTest do
  use GoogleCrawlerWeb.FeatureCase

  @selectors %{
    file_field: "upload[file]"
  }

  feature "upload a file", %{session: session} do
    login_with_user(session)
    |> visit(Routes.upload_path(GoogleCrawlerWeb.Endpoint, :new))
    |> attach_file(Query.file_field(@selectors.file_field),
      path: "test/support/fixtures/csv/valid.csv"
    )
    |> click(Query.button("Upload"))

    session
    |> assert_has(Query.text("File processed successfully"))
  end
end
