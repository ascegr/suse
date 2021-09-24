defmodule Suse.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Suse.Repo,
      # Start the Telemetry supervisor
      SuseWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Suse.PubSub},
      # Start the Endpoint (http/https)
      SuseWeb.Endpoint
      # Start a worker by calling: Suse.Worker.start_link(arg)
      # {Suse.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Suse.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SuseWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
