defmodule Ganondorf.SessionControllerTest do
  use Ganondorf.ConnCase

  test "GET /login", %{conn: conn} do
    conn = get conn, "/login"
    assert html_response(conn, 200) =~ "Login"
  end
end
