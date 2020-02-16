defmodule AbqShowFinderWeb.PageController do
  use AbqShowFinderWeb, :controller
  require Logger

  alias AbqShowFinder.Spotify

  def index(conn, _params) do
    render(
      conn,
      "home.html",
      spotify_url: Application.get_env(:abq_show_finder, :spotify_url)
    )
  end

  def show(conn, %{"code" => spotify_api_code}) do
    with {:ok, auth_body} <- Spotify.request_authorization(spotify_api_code, conn),
         {:ok, top_artists} <- Spotify.list_top_artists(auth_body) do
      render(conn, "shows.html", artists: top_artists["items"])
    else
      {:error, error} ->
        Logger.error(error)

        render(
          conn,
          "home.html",
          spotify_url: Application.get_env(:abq_show_finder, :spotify_url)
        )
    end
  end
end
