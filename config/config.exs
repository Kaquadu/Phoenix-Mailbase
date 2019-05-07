# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mailbase,
  ecto_repos: [Mailbase.Repo]

# Configures the endpoint
config :mailbase, MailbaseWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pCfy0GPly34LR1Z1obHE3jdpr2uZX7KMRvimCY/FHJnVZiL0kRqdkjMIPrdsOpDS",
  render_errors: [view: MailbaseWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mailbase.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :mailbase, Mailbase.Mailer,
  adapter: Bamboo.ConfigAdapter,
  chained_adapter: Bamboo.SMTPAdapter

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
