defmodule GoogleCrawlerWeb.Upload.ViewNewUploadPageTest do
  use GoogleCrawlerWeb.FeatureCase

  feature "view new upload page", %{session: session} do
    login_with_user(session)
    |> visit(Routes.upload_path(GoogleCrawlerWeb.Endpoint, :new))
    |> assert_has(Query.text("Upload a new file!"))
  end
end
