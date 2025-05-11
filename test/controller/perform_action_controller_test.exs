defmodule TestingInElixirWeb.PerformActionControllerTest do
  use ExUnit.Case

  test "perform_action/2" do
    params = %{"some" => "params"}
    response = simulate_http_call("POST", "/perform_action", params)
    assert response.status == 200
    assert response.body == "OK"
  end
end
