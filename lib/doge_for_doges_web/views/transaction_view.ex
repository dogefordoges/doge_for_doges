defmodule DogeForDogesWeb.TransactionView do
  use DogeForDogesWeb, :view
  alias DogeForDogesWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{id: transaction.id,
      transaction_id: transaction.transaction_id,
      southwestX: transaction.southwestX,
      southwestY: transaction.southwestY,
      northeastX: transaction.northeastX,
      northeastY: transaction.northeastY,
      value: transaction.value}
  end
end
