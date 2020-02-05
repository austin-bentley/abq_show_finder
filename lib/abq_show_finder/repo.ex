defmodule AbqShowFinder.Repo do
  use Ecto.Repo,
    otp_app: :abq_show_finder,
    adapter: Ecto.Adapters.Postgres
end
