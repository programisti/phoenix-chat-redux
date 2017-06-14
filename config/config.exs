# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :kodala,
  ecto_repos: [Kodala.Repo]

# Configures the endpoint
config :kodala, Kodala.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MXPuJFrBDs5kVvQaxEGc8h8aqBgGK1D7iMFBNHuIL1qwbJUR6MaPHyQDHKEJfgAz",
  render_errors: [view: Kodala.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Kodala.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
