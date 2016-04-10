defmodule Ganondorf.SessionController do
  use Ganondorf.Web, :controller

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    render conn, changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => user_params}) do
    Repo.get_by(User, username: user_params["username"])
    |> User.authenticate(user_params["password"])
    |> case do
      {:error, changeset} -> render conn, "new.html", changeset: changeset
      {:ok, user} ->
        conn
        |> put_session(:current_user, user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    delete_session(conn, :current_user)
    |> put_flash(:info, 'You have been logged out')
    |> redirect(to: session_path(conn, :new))
  end
end
