defmodule GoogleCrawlerWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.Feature

      import GoogleCrawler.Factory

      alias GoogleCrawlerWeb.Router.Helpers, as: Routes

      def login(session, email, password) do
        session
        |> visit(Routes.user_session_path(GoogleCrawlerWeb.Endpoint, :new))
        |> fill_in(Wallaby.Query.text_field("user_email"), with: email)
        |> fill_in(Wallaby.Query.text_field("user_password"), with: password)
        |> click(Wallaby.Query.button("Login"))
      end

      def login_with_user(session) do
        user = insert(:user)

        login(session, user.email, "hello world!")
      end
    end
  end
end
