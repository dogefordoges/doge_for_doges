defmodule DogeForDoges.AddressesTest do
  use DogeForDoges.DataCase

  alias DogeForDoges.Addresses

  describe "users" do
    alias DogeForDoges.Addresses.User

    @valid_attrs %{address: "some address", coordinates: "some coordinates", signature: "some signature"}
    @update_attrs %{address: "some updated address", coordinates: "some updated coordinates", signature: "some updated signature"}
    @invalid_attrs %{address: nil, coordinates: nil, signature: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Addresses.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Addresses.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Addresses.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Addresses.create_user(@valid_attrs)
      assert user.address == "some address"
      assert user.coordinates == "some coordinates"
      assert user.signature == "some signature"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Addresses.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Addresses.update_user(user, @update_attrs)
      assert user.address == "some updated address"
      assert user.coordinates == "some updated coordinates"
      assert user.signature == "some updated signature"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Addresses.update_user(user, @invalid_attrs)
      assert user == Addresses.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Addresses.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Addresses.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Addresses.change_user(user)
    end
  end
end
