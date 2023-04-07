defmodule IfscService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      IfscServiceWeb.Telemetry,
      # Start the Ecto repository
      IfscService.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: IfscService.PubSub},
      # Start Finch
      {Finch, name: IfscService.Finch},
      # Start the Endpoint (http/https)
      IfscServiceWeb.Endpoint
      # Start a worker by calling: IfscService.Worker.start_link(arg)
      # {IfscService.Worker, arg},
      # IfscService.BankGenServer
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IfscService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IfscServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
