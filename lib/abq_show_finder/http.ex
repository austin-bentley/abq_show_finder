defmodule AbqShowFinder.Http do
  @moduledoc """
  A helper for HTTP calls using Poison
  """
  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, Poison.decode!(body)}
  end

  def handle_response({:ok, %HTTPoison.Response{body: body}}) do
    {:error, body}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end
end
