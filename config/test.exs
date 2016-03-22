use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ganondorf, Ganondorf.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ganondorf, Ganondorf.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "ganondorf_test",
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  template: "template0",
  pool: Ecto.Adapters.SQL.Sandbox
