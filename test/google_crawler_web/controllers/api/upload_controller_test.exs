defmodule GoogleCrawlerWeb.Api.UploadControllerTest do
  use GoogleCrawlerWeb.ConnCase, async: true
  alias GoogleCrawler.Repo
  alias GoogleCrawler.Search.Keyword

  describe "POST create/2" do
    test "creates the keywords when file is succesfully processed", %{conn: conn} do
      user = insert(:user)
      token = insert(:user_token, user: user, context: "api")
      upload = %Plug.Upload{path: "test/support/fixtures/csv/valid.csv", filename: "upload.csv"}

      conn
      |> put_req_header("x-token", Base.encode64(token.token))
      |> post(Routes.api_upload_path(conn, :create), %{upload: %{file: upload}})

      assert Repo.aggregate(Keyword, :count) == 2
    end

    test "returns success message in meta when file is succesfully processed", %{conn: conn} do
      user = insert(:user)
      token = insert(:user_token, user: user, context: "api")
      upload = %Plug.Upload{path: "test/support/fixtures/csv/valid.csv", filename: "upload.csv"}

      result_conn =
        conn
        |> put_req_header("x-token", Base.encode64(token.token))
        |> post(Routes.api_upload_path(conn, :create), %{upload: %{file: upload}})

      assert json_response(result_conn, 201) == %{
               "meta" => [%{"detail" => "File Processed successfully"}]
             }
    end

    test "does NOT create keywords when file is NOT succesfully processed", %{conn: conn} do
      user = insert(:user)
      token = insert(:user_token, user: user, context: "api")

      upload = %Plug.Upload{
        path: "test/support/fixtures/csv/invalid.csv",
        filename: "invalid_upload.csv"
      }

      conn
      |> put_req_header("x-token", Base.encode64(token.token))
      |> post(Routes.api_upload_path(conn, :create), %{upload: %{file: upload}})

      assert Repo.aggregate(Keyword, :count) == 0
    end

    test "returns error message when file is NOT succesfully processed", %{conn: conn} do
      user = insert(:user)
      token = insert(:user_token, user: user, context: "api")
      upload = %Plug.Upload{path: "test/support/fixtures/csv/invalid.csv", filename: "upload.csv"}

      result_conn =
        conn
        |> put_req_header("x-token", Base.encode64(token.token))
        |> post(Routes.api_upload_path(conn, :create), %{upload: %{file: upload}})

      assert json_response(result_conn, 422) == %{
               "errors" => [%{"detail" => "Some error occurred while processing the file"}]
             }
    end
  end
end
