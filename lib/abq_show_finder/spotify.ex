defmodule AbqShowFinder.Spotify do
  @moduledoc """
  The Spotify context.
  """

  import Ecto.Query, warn: false
  alias AbqShowFinder.Repo

  alias AbqShowFinder.Spotify.TopArtist

  @doc """
  Returns the list of top_artists.

  ## Examples

      iex> list_top_artists()
      [%TopArtist{}, ...]

  """
  def list_top_artists do
    # make api call
    Repo.all(TopArtist)
  end
end
