defmodule DogeForDogesWeb.UserControllerTest do
  use DogeForDogesWeb.ConnCase

  alias DogeForDoges.Addresses
  alias DogeForDoges.Addresses.User

  @create_attrs %{
      address: "DJX8ihVnanhfmKMVe8dqCEvvW7JWrRK8zE",
      coordinates: "32.7767,96.7970",
      signature: "H4yVK/RZChChpNzf/hRXsIfrBKTh2qVrJFPTEjRcL7FsU82iPYAoV0dnPW09GP6lav/Wl9GaMz5pUOEXdxxBTU0="
  }
  @update_attrs %{
    address: "some updated address",
    coordinates: "some updated coordinates",
    signature: "some updated signature"
  }
  @invalid_attrs %{address: nil, coordinates: nil, signature: nil}

  def fixture(:user) do
    {:ok, user} = Addresses.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))      

      assert %{
               "id" => id,
               "address" => "DJX8ihVnanhfmKMVe8dqCEvvW7JWrRK8zE",
               "coordinates" => "32.7767,96.7970",
               "signature" => "H4yVK/RZChChpNzf/hRXsIfrBKTh2qVrJFPTEjRcL7FsU82iPYAoV0dnPW09GP6lav/Wl9GaMz5pUOEXdxxBTU0="
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  # describe "update user" do
  #   setup [:create_user]

  #   test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
  #     conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.user_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "address" => "some updated address",
  #              "coordinates" => "some updated coordinates",
  #              "signature" => "some updated signature"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, user: user} do
  #     conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete user" do
  #   setup [:create_user]

  #   test "deletes chosen user", %{conn: conn, user: user} do
  #     conn = delete(conn, Routes.user_path(conn, :delete, user))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.user_path(conn, :show, user))
  #     end
  #   end
  # end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
