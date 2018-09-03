defmodule FawkesWeb.Auth.UserController do
  use FawkesWeb, :controller

  alias Fawkes.Auth
  alias Fawkes.Auth.User

  def new(conn, _params) do
    changeset = Auth.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Auth.authenticate_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: slot_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


end