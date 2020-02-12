defmodule AbqShowFinder.Spotify.TopArtist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "top_artists" do

    timestamps()
  end

  @doc false
  def changeset(top_artist, attrs) do
    top_artist
    |> cast(attrs, [])
    |> validate_required([])
  end
end
