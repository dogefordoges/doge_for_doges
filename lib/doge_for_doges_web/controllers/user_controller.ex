defmodule DogeForDogesWeb.UserController do
  use DogeForDogesWeb, :controller

  alias DogeForDoges.Addresses
  alias DogeForDoges.Addresses.User

  action_fallback DogeForDogesWeb.FallbackController

  def index(conn, _params) do
    users = Addresses.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    %{
      "address" => address,
      "coordinates" => coordinates,
      "signature" => signature
    } = user_params

    with {:ok, true} <- Dogex.verify_message(address, coordinates, signature) do
      with {:ok, %User{} = user} <- Addresses.create_user(user_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("show.json", user: user)
      end
    else
      {:error, reason} -> json(conn, %{:error => reason})
      {:ok, false} -> json(conn, %{:error => "signature was incorrect"})
    end
  end

  def show(conn, %{"id" => id}) do
    user = Addresses.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Addresses.get_user!(id)

    with {:ok, %User{} = user} <- Addresses.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Addresses.get_user!(id)

    with {:ok, %User{}} <- Addresses.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
