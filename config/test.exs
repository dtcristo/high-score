use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :high_score, HighScore.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
  adapter: Sqlite.Ecto,
  database: "high_score_test.sqlite3"

# config :high_score, HighScore.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "high_score_test",
#   hostname: "localhost",
#   pool: Ecto.Adapters.SQL.Sandbox
