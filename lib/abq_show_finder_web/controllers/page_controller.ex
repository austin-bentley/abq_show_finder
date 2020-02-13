defmodule AbqShowFinderWeb.PageController do
  use AbqShowFinderWeb, :controller

  def index(conn, _params) do
    render(
      conn,
      "home.html",
      spotify_url: Application.get_env(:abq_show_finder, :spotify_url)[:value]
    )
  end

  def show(conn, %{"code" => spotify_api_code}) do
    IO.inspect(spotify_api_code, label: "llll")
    render(conn, "shows.html")
  end
end
