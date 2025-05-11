defmodule WeatherTest do
  use ExUnit.Case
  alias TestDemos.Weather

  describe "imminent_rain?/2" do
    test "returns true when will rain in the future" do
      now = datetime_struct(hour: 0, minute: 0, second: 0)

      one_second_from_now = datetime_struct(hour: 0, minute: 0, second: 1)

      weather_data = [weather_struct(one_second_from_now, :rain)]

      assert Weather.imminent_rain?(weather_data, now)
    end
  end

  defp weather_struct(datetime, condition) do
    %Weather{
      datetime: datetime,
      condition: condition == :rain
    }
  end

  defp datetime_struct(options) do
    %DateTime{
      calendar: Calendar.ISO,
      day: 1,
      hour: Keyword.fetch!(options, :hour),
      microsecond: {0, 0},
      minute: Keyword.fetch!(options, :minute),
      month: 1,
      second: Keyword.fetch!(options, :second),
      std_offset: 0,
      time_zone: "Etc/UTC",
      utc_offset: 0,
      year: 2020,
      zone_abbr: "UTC"
    }
  end
end
