defmodule Accountable.Repo do
  use Ecto.Repo,
    otp_app: :accountable,
    adapter: Ecto.Adapters.Postgres
end
