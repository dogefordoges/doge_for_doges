defmodule DogeForDoges.Repo do
  use Ecto.Repo,
    otp_app: :doge_for_doges,
    adapter: Ecto.Adapters.Postgres
end
