defmodule TestingInElixir.Repo do
  use Ecto.Repo,
    otp_app: :testing_in_elixir,
    adapter: Ecto.Adapters.Postgres
end
