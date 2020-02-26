defmodule AbqShowFinder.HoldMyTicket.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %__MODULE__{
          doors: String.t(),
          flyer: map(),
          sold_out: String.t(),
          title: String.t(),
          venue_name: String.t()
        }

  @fields ~w(doors flyer id sold_out title venue_name)a

  schema "events" do
    field :doors, :string
    field :flyer, :map
    field :sold_out, :string
    field :title, :string
    field :venue_name, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, @fields)
    |> validate_required([:id])
  end
end
