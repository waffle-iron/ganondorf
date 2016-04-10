defmodule Ganondorf.RegistrationController do
  use Ganondorf.Web, :controller

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    render conn, changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => user_params}) do
    User.changeset(%User{}, user_params)
    |> User.encrypt_password!
    |> Repo.insert
    |> case do
      {:error, changeset} -> render conn, "new.html", changeset: changeset
      {:ok, new_user} ->
        conn
        |> put_flash(:info, "Successfully registered and logged in")
        |> put_session(:current_user, new_user)
        |> redirect(to: page_path(conn, :index))
    end
  end
end
