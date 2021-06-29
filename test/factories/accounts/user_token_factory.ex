defmodule GoogleCrawler.Accounts.UserTokenFactory do
  defmacro __using__(_opts) do
    quote do
      def user_token_factory(attrs) do
        user_token =
          %GoogleCrawler.Accounts.UserToken{
            token: :crypto.strong_rand_bytes(32)
          }
          |> merge_attributes(attrs)
          |> evaluate_lazy_attributes()
      end
    end
  end
end
