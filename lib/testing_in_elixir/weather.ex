defmodule TestDemos.Weather do
  defstruct datetime: nil, rain?: false

  def imminent_rain?(weather_data, datetime) do
    weather_data.rain? and weather_data.datetime > datetime
  end

  def get_forecast(city) do
    %{
      "city" => city,
      "forecast" => [
        %{"datetime" => ~U[2025-04-17 12:00:00Z], "rain?" => true},
        %{"datetime" => ~U[2025-04-17 13:00:00Z], "rain?" => false},
        %{"datetime" => ~U[2025-04-17 14:00:00Z], "rain?" => true}
      ]
    }
  end
end
