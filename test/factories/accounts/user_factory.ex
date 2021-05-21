defmodule GoogleCrawler.Accounts.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def unique_user_email, do: "user#{System.unique_integer()}@example.com"
      def valid_user_password, do: "hello world!"

      def user_factory do
        %GoogleCrawler.Accounts.User{
          email: unique_user_email(),
          hashed_password: Bcrypt.hash_pwd_salt(valid_user_password())
        }
      end
    end
  end
end
