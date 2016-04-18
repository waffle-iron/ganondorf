defmodule Ganondorf.AuthorizationController do
  use Ganondorf.Web, :controller
  alias Ganondorf.AuthenticationRequest, as: AuthRequest

  plug :prepare_auth_request
  plug :ensure_authenticated

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [
      conn,
      conn.assigns.auth_request.flow_type,
      conn.assigns.auth_request
    ])
  end

  def authorize(conn, :authorization_code_flow, request) do
    raise "NOT READY"
  end

  def authorize(conn, :invalid, request) do
    raise "INVALID"
  end

  def authorize(conn, _any, _request) do
    raise "NOT IMPLEMENTED"
  end

  def ensure_authenticated(conn, _) do
    case Guardian.Plug.current_resource(conn) do
      nil  ->
        put_flash(conn, :info, "Please sign in")
        |> redirect(to: session_path(conn, :new))
        |> halt

      _any -> conn
    end
  end

  def prepare_auth_request(conn, _) do
    assign(conn, :auth_request, AuthRequest.new(conn.params))
  end
end
