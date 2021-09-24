defmodule Suse.Repo do
  use Ecto.Repo,
    otp_app: :suse,
    adapter: Ecto.Adapters.Postgres
end
