defmodule GoogleCrawler.Accounts.UserFactory do
  defmacro __using__(_opts) do
    quote do
      defp user_email, do: "user#{System.unique_integer()}@example.com"
      defp user_password, do: "hello world!"

      def user_factory(attrs) do
        user = %GoogleCrawler.Accounts.User{
          email: attrs[:email] || user_email(),
          hashed_password: Bcrypt.hash_pwd_salt(attrs[:password] || user_password())
        }

        user
        |> merge_attributes(Map.delete(attrs, :password))
        |> evaluate_lazy_attributes()
      end
    end
  end
end
