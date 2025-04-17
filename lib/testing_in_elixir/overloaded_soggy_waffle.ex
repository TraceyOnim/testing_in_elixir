defmodule TestingInElixir.OverloadedSoggyWaffle do
  alias TestDemos.Weather
  @thunderstorm_ids [200, 201, 202, 210, 211, 212, 221, 230, 231, 232]
  @drizzle_ids [300, 301, 302, 310, 311, 312, 313, 314, 321]
  @rain_ids [500, 501, 502, 503, 504, 511, 520, 521, 522, 531]
  @all_rain_ids @thunderstorm_ids ++ @drizzle_ids ++ @rain_ids
  def rain?(city) do
    with {:ok, response} <- SoggyWaffle.WeatherAPI.get_forecast(city) do
      weather_data = parse_response(response)
      Weather.imminent_rain?(weather_data)
    end
  end

  # «parsing logic»
  defp parse_response(response) do
  end
end
