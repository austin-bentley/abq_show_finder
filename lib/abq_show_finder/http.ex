defmodule AbqShowFinder.Http do
  @moduledoc """
  A helper for HTTP calls using Poison
  """

  def handle_response(req, options \\ [])

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}, options) do
    {:ok, Poison.decode!(body, options)}
  end

  def handle_response({:ok, %HTTPoison.Response{body: body}}, _options) do
    {:error, body}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}, _options) do
    {:error, reason}
  end
end
