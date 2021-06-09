defmodule GoogleCrawlerWeb.LayoutView do
  use GoogleCrawlerWeb, :view

  alias Phoenix.{Controller, Naming}

  def body_class(conn) do
    "#{module_class_name(conn)} #{Controller.action_name(conn)}"
  end

  defp module_class_name(conn) do
    conn
    |> Controller.controller_module()
    |> Naming.resource_name("Controller")
    |> String.replace("_", "-")
  end
end
