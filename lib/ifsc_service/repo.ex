defmodule IfscService.Repo do
  use Ecto.Repo,
    otp_app: :ifsc_service,
    adapter: Ecto.Adapters.SQLite3
end
