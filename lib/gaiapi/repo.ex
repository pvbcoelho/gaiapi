defmodule Gaiapi.Repo do
  use Ecto.Repo,
    otp_app: :gaiapi,
    adapter: Ecto.Adapters.Postgres
end
