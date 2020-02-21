defmodule AbqShowFinder.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :doors, :string
      add :flyer, :map
      add :sold_out, :string
      add :title, :string
      add :venue_name, :string

      timestamps()
    end
  end
end
