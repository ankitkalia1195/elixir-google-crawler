defmodule GoogleCrawlerWeb.UploadControllerTest do
  use GoogleCrawlerWeb.ConnCase, async: true
  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.Keyword

  setup :register_and_log_in_user

  describe "GET #new" do
    test "renders the new page", %{conn: conn} do
      response =
        conn
        |> get(Routes.upload_path(conn, :new))
        |> html_response(200)

      assert response =~ "Upload a new file!"
    end
  end

  describe "POST #create" do
    test "creates the keywords when file is succesfully processed", %{conn: conn} do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/valid.csv", filename: "upload.csv"}

      post(conn, Routes.upload_path(conn, :create), %{upload: %{file: upload}})

      assert Repo.aggregate(Keyword, :count) == 2
    end

    test "sets flash message when file is succesfully processed", %{conn: conn} do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/valid.csv", filename: "upload.csv"}

      flash_message =
        conn
        |> post(Routes.upload_path(conn, :create), %{upload: %{file: upload}})
        |> get_flash(:info)

      assert flash_message == "File processed successfully"
    end

    test "does NOT create keywords when file is NOT succesfully processed", %{conn: conn} do
      upload = %Plug.Upload{
        path: "test/support/fixtures/csv/invalid.csv",
        filename: "invalid_upload.csv"
      }

      post(conn, Routes.upload_path(conn, :create), %{upload: %{file: upload}})

      assert Repo.aggregate(Keyword, :count) == 0
    end

    test "sets flash message when file is NOT succesfully processed", %{conn: conn} do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/invalid.csv", filename: "upload.csv"}

      flash_message =
        conn
        |> post(Routes.upload_path(conn, :create), %{upload: %{file: upload}})
        |> get_flash(:error)

      assert flash_message == "Some error occurred while processing the file"
    end
  end
end
