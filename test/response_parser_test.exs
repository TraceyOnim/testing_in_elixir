defmodule TestDemos.ResponseParserTest do
  use ExUnit.Case
  alias TestDemo.ResponseParser
  alias TestDemos.Weather

  @thunderstorm_ids {
    "thunderstorm",
    [200, 201, 202, 210, 211, 212, 221, 230, 231, 232]
  }
  @drizzle_ids {"drizzle", [300, 301, 302, 310, 311, 312, 313, 314, 321]}
  @rain_ids {"rain", [500, 501, 502, 503, 504, 511, 520, 521, 522, 531]}

  # setup_all do function_to_not_call = fn ->
  #   flunk("this function should not have been called") end
  #   function_to_call = fn -> send(self(), :function_called) end %{bad_function: function_to_not_call, good_function: function_to_call}
  #   end

  describe "parse_response/1" do
    for {condition, ids} <- [@thunderstorm_ids, @drizzle_ids, @rain_ids] do
      test "sucess: recognizes #{condition} as a rainy condition" do
        now_unix = DateTime.utc_now() |> DateTime.to_unix()

        for id <- unquote(ids) do
          record = %{"dt" => now_unix, "weather" => [%{"id" => id}]}

          assert {:ok, [weather_struct]} =
                   ResponseParser.parse_response(%{"list" => [record]})

          assert weather_struct.rain? == true,
                 "Expected weather id (#{id}) to be a rain condition"
        end
      end
    end

    test "success: returns rain?: false for any other id codes" do
      {_, thunderstorm_ids} = @thunderstorm_ids
      {_, drizzle_ids} = @drizzle_ids
      {_, rain_ids} = @rain_ids
      all_rain_ids = thunderstorm_ids ++ drizzle_ids ++ rain_ids
      now_unix = DateTime.utc_now() |> DateTime.to_unix()

      for id <- 100..900, id not in all_rain_ids do
        record = %{"dt" => now_unix, "weather" => [%{"id" => id}]}
        assert {:ok, [weather_struct]} = ResponseParser.parse_response(%{"list" => [record]})

        refute weather_struct.rain?, "Expected weather id (#{id}) to not be a rain condition"
      end
    end
  end

  # describe "callbacks" do
  #   setup do
  #     function_to_not_call = fn -> IO.puts("this function should not have been called") end

  #     function_to_call = fn -> send(self(), :function_called) end
  #     %{bad_function: function_to_not_call, good_function: function_to_call}
  #   end

  #   test "does not call the function if the key is wrong", context do
  #     IO.inspect(context)
  #   end
  # end

  # describe "setup scenarios" do
  #   setup [:create_organization, :with_admin, :with_authenticated_user]
  # end

  # setup_all do
  #   response_as_string = File.read!("test/support/fixtures/weather_api_response.json")
  #   response_as_map = Jason.decode!(response_as_string)
  #   %{weather_data: response_as_map}
  # end

  # test "success: accepts a valid payload, returns a list of structs", %{
  #   weather_data: weather_data
  # } do
  #   assert {:ok, parsed_response} = ResponseParser.parse_response(weather_data)

  #   for weather_record <- parsed_response do
  #     assert match?(%Weather{datetime: %DateTime{}, rain?: _rain}, weather_record)
  #     assert is_boolean(weather_record.rain?)
  #   end
  # end

  # def with_authenticated_user(context) do
  #   user = User.create(%{name: "Bob Robertson"}) authenticated_user = TestHelper.authenticate(user)
  #   Map.put(context, :authenticated_user, authenticated_user) end
end
