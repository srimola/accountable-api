# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :accountable,
  ecto_repos: [Accountable.Repo]

# Configures the endpoint
config :accountable, AccountableWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rpDksh952R9UpROsWR+epLWKuFEIOv0cv6KfEAuGBwFL1baumhRwpRXYyCjKG5Jd",
  render_errors: [view: AccountableWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Accountable.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  bash_path: "/api/auth",
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"],
      nickname_field: :username,
      param_nesting: "user",
      uid_field: :username
    ]}
  ]

# TODO: The secret key needs to be updated for production
config :accountable, Accountable.Guardian,
  issuer: "Accountable",
  secret_key: "GcS3zzR6uGy1LekQRAGJoI+QUUwuDhX965yCeaTyk1wwEn0HBVIumtMDgiVrfmf9",

  permissions: %{
    default: [
      :read_users,
      :write_users
    ]
  }

# TODO: Cors_plug will have to updated in prod
config :cors_plug,
  origin: ["*"],
  max_age: 86400

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
