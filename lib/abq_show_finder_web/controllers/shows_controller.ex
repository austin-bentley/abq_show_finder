defmodule AbqShowFinderWeb.ShowsController do
  use AbqShowFinderWeb, :controller
  require Logger

  alias AbqShowFinder.Spotify
  alias AbqShowFinder.HoldMyTicket

  def show(conn, %{"code" => spotify_api_code}) do
    with {:ok, auth_body} <- Spotify.request_authorization(spotify_api_code, conn),
         {:ok, top_artists} <- Spotify.list_top_artists(auth_body),
         {:ok, matched_events} <-
           HoldMyTicket.match_events_by_artists(reduce_top_artists(top_artists)) do
      render(conn, "show.html", artists: top_artists["items"], matched_events: matched_events)
    else
      {:error, error} ->
        Logger.error(error)

        conn
        |> put_view(AbqShowFinderWeb.HomeView)
        |> render(
          "index.html",
          spotify_url: Application.get_env(:abq_show_finder, :spotify_url)
        )
    end
  end

  defp reduce_top_artists(%{"items" => artist_infos}) do
    Enum.reduce(artist_infos, [], fn artist_info, acc -> [artist_info["name"] | acc] end)
  end
end
