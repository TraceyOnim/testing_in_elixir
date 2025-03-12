defmodule TestingInElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TestingInElixirWeb.Telemetry,
      # Start the Ecto repository
      TestingInElixir.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TestingInElixir.PubSub},
      # Start Finch
      {Finch, name: TestingInElixir.Finch},
      # Start the Endpoint (http/https)
      TestingInElixirWeb.Endpoint
      # Start a worker by calling: TestingInElixir.Worker.start_link(arg)
      # {TestingInElixir.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestingInElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestingInElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
