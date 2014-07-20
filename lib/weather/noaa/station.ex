defmodule Weather.NOAA.Station do
  @moduledoc """
  NOAA-specific station functions.  Including how to parse (`from_xml/1`) the
  `Weather.Station` from the XML and to URL (`url`) for the station's current
  observation
  """

  import Weather.NOAA,
         only: [
           find_text: 2
         ]

  def from_xml(document) do
    id = id_from_xml(document)
    latitude = latitude_from_xml(document)
    location = location_from_xml(document)
    longitude = longitude_from_xml(document)

    %Weather.Station{
      id: id,
      latitude: latitude,
      location: location,
      longitude: longitude
    }
  end

  @doc """
  Returns the URL on weather.gov for the `station` or its `station_id`.
  """
  @spec url(Weather.Station.t) :: String.t
  def url(%Weather.Station{id: station_id}), do: url(station_id)

  @spec url(String.t) :: String.t
  def url(station_id) when is_binary(station_id)  do
    "http://w1.weather.gov/xml/current_obs/#{station_id}.xml"
  end

  defp id_from_xml(document) do
    find_text(document, "//station_id")
  end

  defp latitude_from_xml(document) do
    document
    |> find_text("//latitude")
    |> String.to_float
  end

  defp location_from_xml(document) do
    find_text(document, "//location")
  end

  defp longitude_from_xml(document) do
    document
    |> find_text("//longitude")
    |> String.to_float
  end
end
