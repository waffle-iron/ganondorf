defmodule Ganondorf.PageControllerTest do
  use Ganondorf.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Ganondorf"
  end
end
