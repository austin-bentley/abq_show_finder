use Mix.Config

# Configure your database
config :abq_show_finder, AbqShowFinder.Repo,
  username: "postgres",
  password: "postgres",
  database: "abq_show_finder_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :abq_show_finder, AbqShowFinderWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
