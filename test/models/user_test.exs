defmodule Ganondorf.UserTest do
  use Ganondorf.ModelCase

  alias Ganondorf.User

  @valid_attrs %{
    password: "r0flc0pter",
    password_confirmation: "r0flc0pter",
    username: "benfalk"
  }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "#encrypt_password!" do
    hash = 
      User.changeset(%User{}, @valid_attrs)
      |> User.encrypt_password!
      |> Ecto.Changeset.get_field(:encrypted_password)

    assert Comeonin.Bcrypt.checkpw("r0flc0pter", hash)
    refute Comeonin.Bcrypt.checkpw("notgood", hash)
  end

  test "#authenticate" do
    user = %User{
      username: "benfalk",
      encrypted_password: Comeonin.Bcrypt.hashpwsalt("r0flc0pter")
    }
    assert {:error, _changeset} = User.authenticate(nil, nil)
    assert {:error, _changeset} = User.authenticate(user, nil)
    assert {:error, _changeset} = User.authenticate(nil, "")
    assert {:error, _changeset} = User.authenticate(user, "bad-password")
    assert {:ok, user} == User.authenticate(user, "r0flc0pter")
  end
end
