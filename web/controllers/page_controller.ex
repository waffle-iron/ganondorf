defmodule Ganondorf.PageController do
  use Ganondorf.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
