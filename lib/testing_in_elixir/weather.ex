defmodule TestDemos.Weather do
  @type t :: %__MODULE__{}
  defstruct datetime: nil, rain?: false

  @spec imminent_rain?([t()], Datetime.t()) :: boolean()
  def imminent_rain?(weather_data, datetime \\ DateTime.utc_now()) do
    Enum.any?(weather_data, fn
      %__MODULE__{rain?: true} = weather ->
        in_the_next_4_hours?(datetime, weather.datetime)

      _ ->
        false
    end)
  end

  defp in_the_next_4_hours?(datetime, weather_datetime) do
    four_hours_from_now = DateTime.add(datetime, 4 * 60 * 60)

    DateTime.compare(weather_datetime, datetime) in [:gt, :eq] and
      DateTime.compare(weather_datetime, four_hours_from_now) in [:lt, :eq]
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
