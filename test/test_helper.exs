ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(TestingInElixir.Repo, :manual)

Mox.defmock(SoggyWaffle.WeatherAPIMock, for: SoggyWaffle.WeatheAPI.Behaviour)
