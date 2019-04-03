defmodule Mailbase.Repo do
  use Ecto.Repo,
    otp_app: :mailbase,
    adapter: Ecto.Adapters.Postgres
end
