defmodule Weather.NOAA.StationTest do
  import Weather.NOAA.Station,
         only: [
           from_xml: 1,
           url: 1
         ]

  use ExUnit.Case
  use ExVCR.Mock

  setup_all do
    ExVCR.Config.cassette_library_dir(
      "fixtures/vcr_cassettes/weather/noaa/station"
    )
    :ok
  end

  #
  # Helper Functions
  #

  def station, do: %Weather.Station{id: station_id}
  def station_id, do: "KAUS"

  test "from_xml" do
    use_cassette "from_xml" do
      {:ok, xml} = Weather.NOAA.Observation.current_xml(station_id)
      weather_station = from_xml(xml)

      assert weather_station.id == station_id
      assert weather_station.latitude == 30.2
      assert weather_station.location == "Austin-Bergstrom International Airport, TX"
      assert weather_station.longitude == -97.68
    end
  end

  test "url with String.t" do
    assert url(station_id) == "http://w1.weather.gov/xml/current_obs/KAUS.xml"
  end

  test "url with Weather.Station.t" do
    assert url(station) == "http://w1.weather.gov/xml/current_obs/KAUS.xml"
  end
end
