defmodule DogeForDoges.Addresses.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :address, :string
    field :coordinates, :string
    field :signature, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:address, :coordinates, :signature])
    |> validate_required([:address, :coordinates, :signature])
  end
end
