use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ganondorf, Ganondorf.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Used to boost up speed of test suite
# Don't do this in production!!
config :comeonin, :bcrypt_log_rounds, 4

# Configure your database
config :ganondorf, Ganondorf.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "ganondorf_test",
  hostname: System.get_env("DB_HOSTNAME") || "localhost",
  username: System.get_env("DB_USERNAME") || "postgres",
  password: System.get_env("DB_PASSWORD") || "postgres",
  template: "template0",
  pool: Ecto.Adapters.SQL.Sandbox
