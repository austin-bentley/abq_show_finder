defmodule AbqShowFinder.Repo.Migrations.CreateTopArtists do
  use Ecto.Migration

  def change do
    create table(:top_artists) do

      timestamps()
    end

  end
end
