defmodule DogeForDoges do
  @moduledoc """
  DogeForDoges keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def validate_transaction(tx_hash) do
    with {:ok, outputs} <- get_transaction(tx_hash) do
      total = total_value(outputs)
      {:ok, total}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def get_transaction(tx_hash) do
    with {:ok, raw_tx} <- Dogex.get_raw_transaction(tx_hash) do
      with {:ok, %{"vout" => outputs}} <- Dogex.decode_raw_transaction(raw_tx) do
        {:ok, outputs}
      else
        {:error, reason} -> {:error, reason}
      end
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def total_value(decoded_outputs) do
    av_tuples =
      decoded_outputs
      |> Enum.map(fn output ->
        %{
          "value" => value,
          "scriptPubKey" => %{"addresses" => addresses}
        } = output

        {Enum.at(addresses, 0), value}
      end)
      |> Enum.filter(fn {address, _value} ->
        address == Application.get_env(:doge_for_doges, :dogecoin_address)
      end)

    if length(av_tuples) > 0 do
      av_tuples
      |> Enum.map(fn {_address, value} -> value end)
      |> Enum.sum()
    else
      0
    end
  end
  
end
