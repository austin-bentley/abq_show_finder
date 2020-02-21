defmodule AbqShowFinder.HoldMyTicket do
  @moduledoc """
  The HoldMyTicket context.
  """

  import Ecto.Query, warn: false
  alias AbqShowFinder.Repo

  alias AbqShowFinder.HoldMyTicket.Event
  alias AbqShowFinder.Http

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  def get_events_by_page(page) do
    HTTPoison.get(
      "https://holdmyticket.com/api/public/events/nearby/location/albuquerque/page/#{page}/accuracy/100"
    )
    |> Http.handle_response()
  end

  def ingest_new_events(page \\ "0") do
    case get_events_by_page(page) do
      {:ok, %{"events" => []}} ->
        nil

      {:ok, %{"events" => events}} ->
        # update DB
        Enum.map(events, &create_event(&1))
        # next page
        ingest_new_events(increment_page(page))
    end
  end

  def get_upcoming_events(top_artists) do
    # checkDB
    # one =
    #   Event
    #   |> where([e], e.title in ^top_artists)
    #   |> Repo.all()
    # query = from e in "events", where: ^top_artists = ANY(e.title)
    # one = Repo.all(query)

    # select * from mytable where 'Journal'=ANY(pub_types)

    # IO.inspect(one, label: "jjjj")
    # replay ingestion
    ingest_new_events()

    # checkDB
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{source: %Event{}}

  """
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
  end

  defp increment_page(page) do
    String.to_integer(page)
    |> (&(&1 + 1)).()
    |> Integer.to_string()
  end
end
