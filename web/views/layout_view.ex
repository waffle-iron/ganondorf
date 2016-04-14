defmodule Ganondorf.LayoutView do
  use Ganondorf.Web, :view

  def signed_in?(conn) do
    case Guardian.Plug.current_resource(conn) do
      nil -> false
      any -> true
    end
  end

  def get_user(conn) do
    case Guardian.Plug.current_resource(conn) do
      nil -> ""
      user -> "#{user.username}"
    end
  end
end
