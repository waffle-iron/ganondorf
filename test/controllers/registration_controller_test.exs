defmodule Ganondorf.RegistrationControllerTest do
  use Ganondorf.ConnCase

  test "GET /registration", %{conn: conn} do
    conn = get conn, "/registration"
    assert html_response(conn, 200) =~ "Registration"
  end
end
