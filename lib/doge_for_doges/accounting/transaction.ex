defmodule DogeForDoges.Accounting.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :northeastX, :float
    field :northeastY, :float
    field :southwestX, :float
    field :southwestY, :float
    field :transaction_id, :string
    field :value, :float

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:transaction_id, :southwestX, :southwestY, :northeastX, :northeastY, :value])
    |> validate_required([
      :transaction_id,
      :southwestX,
      :southwestY,
      :northeastX,
      :northeastY,
      :value
    ])
  end
end
