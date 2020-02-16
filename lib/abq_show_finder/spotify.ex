defmodule AbqShowFinder.Spotify do
  @moduledoc """
  The Spotify context.
  """

  import Ecto.Query, warn: false

  alias AbqShowFinder.Spotify.TopArtist

  @doc """
  Returns the list of top_artists from Spotify api.

  ## Examples

      iex> list_top_artists()
      [%TopArtist{}, ...]

  """
  def list_top_artists(%{
        "access_token" => access_token,
        "expires_in" => _expires_in,
        "refresh_token" => _refresh_token,
        "scope" => _scope,
        "token_type" => _token_type
      }) do
    case HTTPoison.get(
           "https://api.spotify.com/v1/me/top/artists",
           [
             Authorization: "Bearer #{access_token}",
             "Content-Type": "application/json",
             Accept: "application/json"
           ],
           params: %{limit: 50, time_range: "medium_term"}
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Poison.decode!(body)}

      {:ok, %HTTPoison.Response{body: body}} ->
        {:error, body}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def list_top_artists(_), do: {:error, "something went wrong"}

  @doc """
  Requests authorization from Spotify api.
  """
  def request_authorization("", _), do: {:error, "No code supplied"}
  def request_authorization(nil, _), do: {:error, "No code supplied"}

  def request_authorization(spotify_api_code, conn) do
    current_url = remove_query_params(Plug.Conn.request_url(conn))
    IO.inspect(Application.get_env(:abq_show_finder, :spotify_account_key), label: "hhhhhh")

    case HTTPoison.post(
           "https://accounts.spotify.com/api/token",
           [],
           [
             Authorization:
               "Basic #{
                 Base.encode64(
                   "ff570fbf9c52459a8eae080c5cab560c:#{
                     Application.get_env(:abq_show_finder, :spotify_account_key)
                   }"
                 )
               }",
             "Content-Type": "application/x-www-form-urlencoded"
           ],
           params: %{
             grant_type: "authorization_code",
             code: spotify_api_code,
             redirect_uri: current_url
           }
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Poison.decode!(body)}

      {:ok, %HTTPoison.Response{body: body}} ->
        {:error, body}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp remove_query_params(string) do
    [h | _t] = String.split(string, "?")
    h
  end
end
