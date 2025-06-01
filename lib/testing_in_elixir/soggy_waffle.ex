defmodule TestingInElixir.SoggyWaffle do
  alias TestDemos.Weather
  alias TestingInElixir.SoggyWaffleWeatherApi
  alias TestingInElixir.ResponseParser
  alias TestingInElixir.Weather

  def api_key do
    "1234567890"
  end

  # def rain?(city, datetime, weather_fn \\ &Weather.get_forecast/1) do
  #   with {:ok, response} <- weather_fn.(city) do
  #     {:ok, weather_data} = TestDemo.ResponseParser.parse_response(response)
  #     Weather.imminent_rain?(weather_data, datetime)
  #   end
  # end

  # def rain?(city, datetime) do
  #   with {:ok, response} <- SoggyWaffleWeatherApi.get_forecast(city) do
  #     weather_data =
  #       ResponseParser.parse_response(response)

  #     Weather.imminent_rain?(weather_data, datetime)
  #   end
  # end

  # double dependency
  # def rain?(city, datetime, weather_api_module \\ SoggyWaffle.WeatherAPI) do
  #   with {:ok, response} <- weather_api_module.get_forecast(city) do
  #     weather_data =
  #       SoggyWaffle.WeatherAPI.ResponseParser.parse_response(response)

  #     SoggyWaffle.Weather.imminent_rain?(weather_data, datetime)
  #   end
  # end

  def rain?(city, datetime) do
    weather_api_module=
    Application.get_env(:soggy_waffle, :weather_api_module, SoggyWaffle.WeatherAPI)
    with {:ok, response} <- weather_api_module.get_forecast(city) do
      weather_data =
        SoggyWaffle.WeatherAPI.ResponseParser.parse_response(response)

      SoggyWaffle.Weather.imminent_rain?(weather_data, datetime)
    end
  end
end
