defmodule Ganondorf.AuthorizationController do
  use Ganondorf.Web, :controller
  alias Ganondorf.AuthenticationRequest

  def authorize(conn, params) do
    auth_request = AuthenticationRequest.new(params)
    case AuthenticationRequest.flow_type(auth_request) do
      :authorization_code_flow -> authorization_code_flow(conn, auth_request)
      :implicit_flow -> implicit_flow(conn, auth_request)
      :hybrid_flow -> hybrid_flow(conn, auth_request)
      :invalid -> invalid_flow(conn, auth_request)
    end
  end

  defp authorization_code_flow(conn, auth_request), do: raise "NOT IMPLEMENTED"
  defp implicit_flow(conn, auth_request), do: raise "NOT IMPLEMENTED"
  defp hybrid_flow(conn, auth_request), do: raise "NOT IMPLEMENTED"
  defp invalid_flow(conn, auth_request), do: raise "NOT IMPLEMENTED"
end
