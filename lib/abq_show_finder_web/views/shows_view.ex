defmodule AbqShowFinderWeb.ShowsView do
  use AbqShowFinderWeb, :view

  alias AbqShowFinder.HoldMyTicket.Event

  def get_flyer_img(%Event{flyer: %{"flyer_lg" => flyer_url}}), do: flyer_url
  def get_flyer_img(%Event{flyer: %{"flyer_mid" => flyer_url}}), do: flyer_url
  def get_flyer_img(%Event{flyer: %{"flyer_square" => flyer_url}}), do: flyer_url
  def get_flyer_img(%Event{flyer: %{"flyer" => flyer_url}}), do: flyer_url
  def get_flyer_img(%Event{flyer: %{"flyer_thumb" => flyer_url}}), do: flyer_url
end
