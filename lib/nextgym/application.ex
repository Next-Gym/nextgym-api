defmodule Nextgym.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      NextgymWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Nextgym.PubSub},
      # Start Finch
      {Finch, name: Nextgym.Finch},
      # Start the Endpoint (http/https)
      NextgymWeb.Endpoint
      # Start a worker by calling: Nextgym.Worker.start_link(arg)
      # {Nextgym.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nextgym.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NextgymWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
