defmodule TestingInElixir.SoggyWaffleWeatherApi do
  alias TestingInElixir.SoggyWaffle


  @spec get_forecast(String.t()) :: {:ok, map()} | {:error, reason :: term()}
  def get_forecast(city) when is_binary(city) do
    api_id = SoggyWaffle.api_key()

    query_params = URI.encode_query(%{"q" => city, "APPID" => app_id})

    url = "https://api.openweathermap.org/data/2.5/forecast?" <> query_params

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{{status_code: 200}=response}} ->
        {:ok, Jason.decode!(response.body)}

        {:ok, %HTTPoison.Response{status_code: status_code}} ->
          {:error, {:status, status_code}}

          error -> error
    end
  end
end
