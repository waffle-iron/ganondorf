defmodule Ganondorf.AuthenticationRequest do
  @moduledoc """
  Used to model a client's authentication request for a user.
  """

  @type t :: %__MODULE__{}
  @type flow_type :: :authorization_code_flow | :implicit_flow | :hybrid_flow

  @structure [
    scope: "", 
    response_type: "",
    client_id: "",
    redirect_url: "",
    state: "",
    response_mode: "",
    none: "",
    display: "",
    prompt: "",
    max_age: "",
    ui_locales: "",
    id_token_hint: "",
    login_hint: "",
    acr_values: ""
  ]

  @keys Keyword.keys(@structure)

  defstruct @structure 

  @doc """
  Builds a Ganondorf.AuthenticationRequest from map parameters

  ## Examples
      iex> Ganondorf.AuthenticationRequest.new
      %Ganondorf.AuthenticationRequest{}

      iex> Ganondorf.AuthenticationRequest.new(%{"scope"=>"openid"})
      %Ganondorf.AuthenticationRequest{scope: "openid"}
  """
  @spec new(Map) :: __MODULE__.t
  def new(params \\ %{}) when is_map(params) do
     Enum.map(@keys, fn key ->
       {key, Map.get(params, key) || Map.get(params, "#{key}", @structure[key])}
     end)
     |> Enum.reduce(%__MODULE__{}, fn { key, value }, acc ->
       Map.put(acc, key, "#{value}")
     end)
  end

  @doc """
  Given a Ganondorf.AuthenticationRequest, tries to determine what the flow type
  should be based on the `response_type`.  It should follow this table, allowing
  for the types to be in any order:

    | response_type value | flow                    |
    |---------------------|-------------------------|
    | code                | authorization_code_flow |
    | id_token            | implicit_flow           |
    | id_token token      | implicit_flow           |
    | code id_token       | hybrid_flow             |
    | code token          | hybrid_flow             |
    | code id_token token | hybrid_flow             |

  It will return `:invalid` if it does match the above table

  ## Examples
     iex> %Ganondorf.AuthenticationRequest{response_type: "code"}
     ...> |> Ganondorf.AuthenticationRequest.flow_type
     :authorization_code_flow

     iex> %Ganondorf.AuthenticationRequest{response_type: "id_token"}
     ...> |> Ganondorf.AuthenticationRequest.flow_type
     :implicit_flow

     iex> %Ganondorf.AuthenticationRequest{response_type: "id_token token code"}
     ...> |> Ganondorf.AuthenticationRequest.flow_type
     :hybrid_flow

     iex> %Ganondorf.AuthenticationRequest{response_type: "foobar"}
     ...> |> Ganondorf.AuthenticationRequest.flow_type
     :invalid
  """
  @spec flow_type(__MODULE__.t) :: __MODULE__.flow_type | :invalid
  def flow_type(%__MODULE__{response_type: "code"}), do: :authorization_code_flow
  def flow_type(%__MODULE__{response_type: "id_token"}), do: :implicit_flow
  def flow_type(%__MODULE__{response_type: "id_token token"}), do: :implicit_flow
  def flow_type(%__MODULE__{response_type: "token id_token"}), do: :implicit_flow
  def flow_type(%__MODULE__{response_type: "code id_token"}), do: :hybrid_flow
  def flow_type(%__MODULE__{response_type: "id_token code"}), do: :hybrid_flow
  def flow_type(%__MODULE__{response_type: "code token"}), do: :hybrid_flow
  def flow_type(%__MODULE__{response_type: "token code"}), do: :hybrid_flow
  def flow_type(%__MODULE__{response_type: "code token id_token"}), do: :hybrid_flow
  def flow_type(%__MODULE__{response_type: "code id_token token"}), do: :hybrid_flow
  def flow_type(%__MODULE__{response_type: "token id_token code"}), do: :hybrid_flow
  def flow_type(%__MODULE__{response_type: "token code id_token"}), do: :hybrid_flow
  def flow_type(%__MODULE__{response_type: "id_token code token"}), do: :hybrid_flow
  def flow_type(%__MODULE__{response_type: "id_token token code"}), do: :hybrid_flow
  def flow_type(%__MODULE__{}), do: :invalid
end
