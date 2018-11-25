defmodule DogeForDogesWeb.TransactionController do
  use DogeForDogesWeb, :controller

  alias DogeForDoges.Accounting
  alias DogeForDoges.Accounting.Transaction

  action_fallback DogeForDogesWeb.FallbackController

  def index(conn, _params) do
    transactions = Accounting.list_transactions()
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, value} <-
    DogeForDoges.validate_transaction(Map.get(transaction_params, "transaction_id")) do
      #Add value to transaction_params
      with {:ok, %Transaction{} = transaction} <-
             Accounting.create_transaction(transaction_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.transaction_path(conn, :show, transaction))
        |> render("show.json", transaction: transaction)
      end
    else
      {:error, reason} -> json(conn, %{"error" => reason})
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Accounting.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Accounting.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <-
           Accounting.update_transaction(transaction, transaction_params) do
      render(conn, "show.json", transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Accounting.get_transaction!(id)

    with {:ok, %Transaction{}} <- Accounting.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
