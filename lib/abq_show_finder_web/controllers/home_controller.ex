defmodule AbqShowFinderWeb.HomeController do
  use AbqShowFinderWeb, :controller

  def index(conn, _params) do
    render(
      conn,
      "index.html",
      spotify_url: Application.get_env(:abq_show_finder, :spotify_url)
    )
  end
end
