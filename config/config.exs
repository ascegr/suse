# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :suse,
  ecto_repos: [Suse.Repo]

# Configures the endpoint
config :suse, SuseWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VEKxcdt26PK1AyZ4wBsSMjqRucsyszW8efFV0ocPTPN9WZcivKZgIZlxwjRaj7ZU",
  render_errors: [view: SuseWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Suse.PubSub,
  live_view: [signing_salt: "k5ebGXRv"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
