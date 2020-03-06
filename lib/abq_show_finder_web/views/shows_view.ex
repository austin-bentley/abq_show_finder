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
      day =
        Timex.weekday(date_time)
        |> Timex.day_name()

      month = Timex.month_shortname(date_time.month)
      "#{day}, #{month} #{date_time.day} at #{get_hour(date_time.hour)}"
    end
  end

  defp get_hour(hour) when hour >= 12, do: "#{hour - 12}pm"
  defp get_hour(hour) when hour < 12, do: "#{hour}am"
end
