defmodule DogeForDoges.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :address, :string
      add :coordinates, :string
      add :signature, :string

      timestamps()
    end

  end
end
