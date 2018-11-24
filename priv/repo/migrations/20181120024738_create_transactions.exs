defmodule DogeForDoges.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :transaction_id, :string
      add :southwestX, :float
      add :southwestY, :float
      add :northeastX, :float
      add :northeastY, :float
      add :value, :float

      timestamps()
    end
  end
end
