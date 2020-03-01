defmodule AbqShowFinderWeb.HoldMyTicketController do
  use AbqShowFinderWeb, :controller

  alias AbqShowFinder.HoldMyTicket

  def index(conn, %{"hmt_id" => hmt_id}) do
    case HoldMyTicket.get_event_by_id(hmt_id) do
      {:ok, %{"event" => %{"ticket_url" => url}}} ->
        redirect(conn, external: url)

      {:error, _reason} ->
        # redirect back to shows page instead
        conn
        |> put_view(AbqShowFinderWeb.HomeView)
        |> render(
          "index.html",
          spotify_url: Application.get_env(:abq_show_finder, :spotify_url)
        )
    end
  end
end
