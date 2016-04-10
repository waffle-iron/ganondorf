defmodule Ganondorf.User do
  use Ganondorf.Web, :model
  alias Ganondorf.Repo
  alias Ganondorf.User

  import Comeonin.Bcrypt, only: [hashpwsalt: 1, checkpw: 2, dummy_checkpw: 0]

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :username, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @required_fields ~w(username password password_confirmation)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:username)
    |> validate_length(:password, min: 1)
    |> validate_length(:password_confirmation, min: 1)
    |> validate_confirmation(:password)
  end

  def encrypt_password!(changeset) do
    changeset
    |> put_change(:encrypted_password, hashpwsalt(changeset.params["password"]))
  end

  def authenticate(user, password) when is_nil(user) or is_nil(password) do
    bad_authentication
  end
  def authenticate(user, password) do
    if checkpw(password, user.encrypted_password) do
      {:ok, user}
    else
      bad_authentication
    end
  end

  defp bad_authentication do
    dummy_checkpw
    changeset =
      Ganondorf.User.changeset(%Ganondorf.User{})
      |> add_error(:general, "username or password is wrong")
    {:error, changeset}
  end
end
