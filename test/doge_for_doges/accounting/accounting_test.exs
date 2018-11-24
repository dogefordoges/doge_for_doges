defmodule DogeForDoges.AccountingTest do
  use DogeForDoges.DataCase

  alias DogeForDoges.Accounting

  describe "transactions" do
    alias DogeForDoges.Accounting.Transaction

    @valid_attrs %{
      northeastX: 120.5,
      northeastY: 120.5,
      southwestX: 120.5,
      southwestY: 120.5,
      transaction_id: "some transaction_id",
      value: 120.5
    }
    @update_attrs %{
      northeastX: 456.7,
      northeastY: 456.7,
      southwestX: 456.7,
      southwestY: 456.7,
      transaction_id: "some updated transaction_id",
      value: 456.7
    }
    @invalid_attrs %{
      northeastX: nil,
      northeastY: nil,
      southwestX: nil,
      southwestY: nil,
      transaction_id: nil,
      value: nil
    }

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounting.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Accounting.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Accounting.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = Accounting.create_transaction(@valid_attrs)
      assert transaction.northeastX == 120.5
      assert transaction.northeastY == 120.5
      assert transaction.southwestX == 120.5
      assert transaction.southwestY == 120.5
      assert transaction.transaction_id == "some transaction_id"
      assert transaction.value == 120.5
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounting.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()

      assert {:ok, %Transaction{} = transaction} =
               Accounting.update_transaction(transaction, @update_attrs)

      assert transaction.northeastX == 456.7
      assert transaction.northeastY == 456.7
      assert transaction.southwestX == 456.7
      assert transaction.southwestY == 456.7
      assert transaction.transaction_id == "some updated transaction_id"
      assert transaction.value == 456.7
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounting.update_transaction(transaction, @invalid_attrs)

      assert transaction == Accounting.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Accounting.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Accounting.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Accounting.change_transaction(transaction)
    end
  end
end
