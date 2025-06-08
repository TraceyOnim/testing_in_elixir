defmodule SoggyWaffleTest do
  use ExUnit.Case
  import ExUnit.CaptureLog

  describe "rain?/2" do
    test "success: gets forecasts, returns true for imminent rain" do
      now = DateTime.utc_now()
      future_unix = DateTime.to_unix(now) + 1
      expected_city = Enum.random(["Denver", "Los Angeles", "New York"])
      test_pid = self()

      weather_fn_double = fn city ->
        send(test_pid, {:get_forecast_called, city})

        data = [
          %{
            "dt" => future_unix,
            "weather" => [%{"id" => _drizzle_id = 300}]
          }
        ]

        {:ok, %{"list" => data}}
      end

      assert SoggyWaffle.rain?(expected_city, now, weather_fn_double)
      assert_received {:get_forecast_called, ^expected_city}
    end

    describe "rain?/2" do
      test "success: gets forecasts, returns true for imminent rain" do
        log =
          capture_log(fn ->
            SoggyWaffle.rain?("Los Angeles", DateTime.utc_now())
          end)

        assert log =~ "Getting forecast for city: Los Angeles"
      end
    end

    describe "rain?/2" do
      test "success: gets forecasts, returns true for imminent rain" do
        stub(SoggyWaffle.WeatherAPIMock, :get_forecast, fn city ->
          Logger.info("Getting forecast for city: #{city}")

          response = %{
            "list" => [
              %{
                "dt" => DateTime.to_unix(DateTime.utc_now()) + _seconds = 60,
                "weather" => [%{"id" => _thunderstorm = 231}]
              }
            ]
          }

          {:ok, response}
        end)

        log =
          capture_log(fn ->
            assert SoggyWaffle.rain?("Los Angeles", DateTime.utc_now())
          end)

        assert log =~ "Getting forecast for city: Los Angeles"
      end
    end
  end
end
