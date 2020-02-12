defmodule AbqShowFinder.SpotifyTest do
  use AbqShowFinder.DataCase

  alias AbqShowFinder.Spotify

  describe "top_artists" do
    alias AbqShowFinder.Spotify.TopArtist

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def top_artist_fixture(attrs \\ %{}) do
      {:ok, top_artist} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Spotify.create_top_artist()

      top_artist
    end

    test "list_top_artists/0 returns all top_artists" do
      top_artist = top_artist_fixture()
      assert Spotify.list_top_artists() == [top_artist]
    end

    test "get_top_artist!/1 returns the top_artist with given id" do
      top_artist = top_artist_fixture()
      assert Spotify.get_top_artist!(top_artist.id) == top_artist
    end

    test "create_top_artist/1 with valid data creates a top_artist" do
      assert {:ok, %TopArtist{} = top_artist} = Spotify.create_top_artist(@valid_attrs)
    end

    test "create_top_artist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spotify.create_top_artist(@invalid_attrs)
    end

    test "update_top_artist/2 with valid data updates the top_artist" do
      top_artist = top_artist_fixture()
      assert {:ok, %TopArtist{} = top_artist} = Spotify.update_top_artist(top_artist, @update_attrs)
    end

    test "update_top_artist/2 with invalid data returns error changeset" do
      top_artist = top_artist_fixture()
      assert {:error, %Ecto.Changeset{}} = Spotify.update_top_artist(top_artist, @invalid_attrs)
      assert top_artist == Spotify.get_top_artist!(top_artist.id)
    end

    test "delete_top_artist/1 deletes the top_artist" do
      top_artist = top_artist_fixture()
      assert {:ok, %TopArtist{}} = Spotify.delete_top_artist(top_artist)
      assert_raise Ecto.NoResultsError, fn -> Spotify.get_top_artist!(top_artist.id) end
    end

    test "change_top_artist/1 returns a top_artist changeset" do
      top_artist = top_artist_fixture()
      assert %Ecto.Changeset{} = Spotify.change_top_artist(top_artist)
    end
  end
end
