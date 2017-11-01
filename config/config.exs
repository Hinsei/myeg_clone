# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :myeg,
  ecto_repos: [Myeg.Repo]

# Configures the endpoint
config :myeg, MyegWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aCbG/990EEv7RLNMMeQauQ7KMQb88KuwLKmbg94EshkXB6qvE3KNxLJye/Gmd1Aq",
  render_errors: [view: MyegWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Myeg.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
