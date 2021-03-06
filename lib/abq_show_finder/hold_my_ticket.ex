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

  @doc """
  Calls hold my ticket api by page

  ## Examples
      iex> get_events_by_page("0")
  """

  def get_events_by_page(page) do
    HTTPoison.get(
      "https://holdmyticket.com/api/public/events/nearby/location/albuquerque/page/#{page}/accuracy/100"
    )
    |> Http.handle_response()
  end

  @doc """
  Makes api call to get hold my ticket event by ID.

  ## Examples
      iex> get_event_by_id()
  """

  def get_event_by_id(id) do
    HTTPoison.get("https://holdmyticket.com/api/public/events/get/id/#{id}")
    |> Http.handle_response()
  end

  @doc """
  Makes api calls to get all new events and store them in the DB.

  ## Examples
      iex> ingest_new_events()
  """

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

  @doc """
  Gets list of upcoming events.

  ## Examples

      iex> get_upcoming_events()
      [%Event{}]
  """
  def get_upcoming_events() do
    {:ok, Repo.all(Event)}
    # update to actually check date of event
  end

  @doc """
  Finds an event based on a list of artists.

  ## Examples

      iex> match_events_by_artists(["Jimi hendrix", "Elliot Smith"])
      [%Event{}]
  """

  def match_events_by_artists(top_artists) do
    case Repo.all(Event)
         |> Enum.reduce([], fn event, acc ->
           case Enum.map(top_artists, fn artist ->
                  String.contains?(String.downcase(event.title), String.downcase(artist))
                end)
                |> Enum.any?(fn x -> x == true end) do
             true ->
               [event | acc]

             false ->
               acc
           end
         end) do
      [] ->
        {:ok, []}

      events ->
        {:ok, events}
    end
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
