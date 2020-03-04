defmodule AbqShowFinderWeb.ShowsView do
  use AbqShowFinderWeb, :view

  alias AbqShowFinder.HoldMyTicket.Event

  def get_flyer_img(%Event{flyer: %{"flyer_lg" => flyer_url}}), do: flyer_url
  def get_flyer_img(%Event{flyer: %{"flyer_mid" => flyer_url}}), do: flyer_url
  def get_flyer_img(%Event{flyer: %{"flyer_square" => flyer_url}}), do: flyer_url
  def get_flyer_img(%Event{flyer: %{"flyer" => flyer_url}}), do: flyer_url
  def get_flyer_img(%Event{flyer: %{"flyer_thumb" => flyer_url}}), do: flyer_url

  def display_date_time(time) do
    with {:ok, naive_date_time} <- Timex.parse(time, "{RFC3339z}"),
         {:ok, date_time} <- DateTime.from_naive(naive_date_time, "Etc/UTC") do
      "#{date_time.year}-#{date_time.month}-#{date_time.day} #{date_time.hour}"
    end
  end
end
