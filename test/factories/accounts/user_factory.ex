defmodule GoogleCrawler.Accounts.UserFactory do
  defmacro __using__(_opts) do
    quote do
      defp user_email, do: "user#{System.unique_integer()}@example.com"
      defp user_password, do: "hello world!"

      def user_factory do
        %GoogleCrawler.Accounts.User{
          email: user_email(),
          hashed_password: Bcrypt.hash_pwd_salt(user_password())
        }
      end
    end
  end
end
