defmodule GoogleCrawlerWeb.UploadControllerTest do
  use GoogleCrawlerWeb.ConnCase, async: true
  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.Keyword

  setup :register_and_log_in_user

  describe "GET new/2" do
    test "renders the new page", %{conn: conn} do
      response =
        conn
        |> get(Routes.upload_path(conn, :new))
        |> html_response(200)

      assert response =~ "Upload a new file!"
    end
  end

  describe "POST create/2" do
    test "creates the keywords when file is succesfully processed", %{conn: conn} do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/valid.csv", filename: "upload.csv"}

      post(conn, Routes.upload_path(conn, :create), %{upload: %{file: upload}})

      assert Repo.aggregate(Keyword, :count) == 2
    end

    test "sets flash message and redirects when file is succesfully processed", %{conn: conn} do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/valid.csv", filename: "upload.csv"}

      result_conn = post(conn, Routes.upload_path(conn, :create), %{upload: %{file: upload}})

      assert result_conn.status == 302
      assert redirected_to(result_conn) == Routes.keyword_path(conn, :index)
      assert get_flash(result_conn, :info) == "File processed successfully"
    end

    test "does NOT create keywords when file is NOT succesfully processed", %{conn: conn} do
      upload = %Plug.Upload{
        path: "test/support/fixtures/csv/invalid.csv",
        filename: "invalid_upload.csv"
      }

      post(conn, Routes.upload_path(conn, :create), %{upload: %{file: upload}})

      assert Repo.aggregate(Keyword, :count) == 0
    end

    test "sets flash message and redirects when file is NOT succesfully processed", %{conn: conn} do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/invalid.csv", filename: "upload.csv"}

      result_conn = post(conn, Routes.upload_path(conn, :create), %{upload: %{file: upload}})

      assert result_conn.status == 302
      assert redirected_to(result_conn) == Routes.upload_path(conn, :new)
      assert get_flash(result_conn, :error) == "Some error occurred while processing the file"
    end
  end
end
