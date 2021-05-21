defmodule GoogleCrawlerWeb.Upload.ViewNewUploadPageTest do
  use GoogleCrawlerWeb.FeatureCase

  feature "view new upload page", %{session: session} do
    session
    |> login_with_user
    |> visit(Routes.upload_path(GoogleCrawlerWeb.Endpoint, :new))
    |> assert_has(Query.text("Upload a new file!"))
  end
end
