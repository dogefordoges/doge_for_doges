use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :doge_for_doges, DogeForDogesWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :doge_for_doges, DogeForDoges.Repo,
  username: "postgres",
  password: "dogecoin",
  database: "doge_for_doges_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

import_config "test.secret.exs"
