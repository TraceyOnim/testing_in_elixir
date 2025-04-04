defmodule TestDemo.ResponseParser do
  alias TestDemos.Weather
  @thunderstorm_ids [200, 201, 202, 210, 211, 212, 221, 230, 231, 232]
  @drizzle_ids [300, 301, 302, 310, 311, 312, 313, 314, 321]
  @rain_ids [500, 501, 502, 503, 504, 511, 520, 521, 522, 531]
  @all_rain_ids @thunderstorm_ids ++ @drizzle_ids ++ @rain_ids

  def parse_response(response) do
    results = response["list"]

    Enum.reduce_while(results, {:ok, []}, fn
      %{
        "dt" => datetime,
        "weather" => [%{"id" => condition_id}]
      },
      {:ok, weather_list} ->
        new_weather = %Weather{
          datetime: DateTime.from_unix!(datetime),
          rain?: condition_id in @all_rain_ids
        }

        {:cont, {:ok, [new_weather | weather_list]}}

      _anything_else, _acc ->
        {:halt, {:error, :response_format_invalid}}
    end)
  end
end
