defmodule TestingInElixir.SoggyWaffle do
  alias TestDemos.Weather

  def rain?(city, datetime, weather_fn \\ &Weather.get_forecast/1) do
    with {:ok, response} <- weather_fn.(city) do
      {:ok, weather_data} = TestDemo.ResponseParser.parse_response(response)
      Weather.imminent_rain?(weather_data, datetime)
    end
  end
end
