defmodule Ganondorf.AuthenticationRequestTest do
  use ExUnit.Case, async: true
  alias Ganondorf.AuthenticationRequest
  doctest AuthenticationRequest

  test "#new builds an AuthenticationRequest from a map" do
    assert AuthenticationRequest.new() == %AuthenticationRequest{}
    assert AuthenticationRequest.new(%{}) == %AuthenticationRequest{}
    assert AuthenticationRequest.new(%{"scope"=>:test}) == %AuthenticationRequest{scope: "test"}
    assert AuthenticationRequest.new(%{scope: :test}) == %AuthenticationRequest{scope: "test"}
    assert AuthenticationRequest.new(%{"rofl" => :copter}) == %AuthenticationRequest{}
  end

  test "#flow_type" do
    flow_type = &AuthenticationRequest.flow_type/1
    assert flow_type.(%AuthenticationRequest{response_type: "code"}) == :authorization_code_flow
    assert flow_type.(%AuthenticationRequest{response_type: "id_token"}) == :implicit_flow
    assert flow_type.(%AuthenticationRequest{response_type: "id_token token"}) == :implicit_flow
    assert flow_type.(%AuthenticationRequest{response_type: "id_token token code"}) == :hybrid_flow
    assert flow_type.(%AuthenticationRequest{response_type: "id_token token code hog"}) == :invalid
  end
end
