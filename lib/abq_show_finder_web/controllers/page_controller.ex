defmodule AbqShowFinderWeb.PageController do
  use AbqShowFinderWeb, :controller

  def index(conn, _params) do
    render(conn, "home.html")
  end
end
