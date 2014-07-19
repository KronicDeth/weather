defmodule Weather.NOAA.ObservationTest do
  import Weather.NOAA,
         only: [
           xmlNamespace: 0
         ]
  import Weather.NOAA.Observation,
         only: [
           current_raw: 1,
           current_xml: 1
         ]

  require Record
  require Weather.NOAA

  use ExUnit.Case
  use ExVCR.Mock

  setup_all do
    ExVCR.Config.cassette_library_dir(
      "fixtures/vcr_cassettes/weather/noaa/observation"
    )
    :ok
  end

  #
  # Helper Functions
  #

  def invalid_id, do: "BAD"
  def invalid_weather_station, do: %Weather.Station{id: invalid_id}
  def valid_id, do: "KAUS"
  def valid_weather_station, do: %Weather.Station{id: valid_id}

  #
  # Tests
  #

  test "current_raw with Weather.Station.t with invalid id" do
    use_cassette "current_raw/invalid_id" do
      assert current_raw(invalid_weather_station) == {:error, :not_found}
    end
  end

  test "current_raw with Weather.Station.t with valid id" do
    use_cassette "current_raw/valid_id" do
      {flag, body} = current_raw(valid_weather_station)

      assert flag == :ok
      assert String.contains?(body, "<station_id>#{valid_id}</station_id>")
    end
  end

  test "current_raw with invalid id" do
    use_cassette "current_raw/invalid_id" do
      assert current_raw(invalid_id) == {:error, :not_found}
    end
  end

  test "current_raw with valid id" do
    use_cassette "current_raw/valid_id" do
      {flag, body} = current_raw(valid_id)

      assert flag == :ok
      assert String.contains?(body, "<station_id>#{valid_id}</station_id>")
    end
  end

  test "currrent_xml with Weather.Station.t with invalid id" do
    use_cassette "current_raw/invalid_id" do
      assert current_xml(invalid_weather_station) == {:error, :not_found}
    end
  end

  test "current_xml with Weather.Station.t with valid id" do
    use_cassette "current_raw/valid_id" do
      {flag, xml} = current_xml(valid_weather_station)

      assert flag == :ok
      
      [station_id_text] = Exmerl.XPath.find(xml, "//station_id/text()")

      assert Record.record?(station_id_text, :xmlText)

      keywordList = Weather.NOAA.xmlText(station_id_text)

      assert keywordList[:value] == 'KAUS'
    end
  end

  test "currrent_xml with invalid id" do
    use_cassette "current_raw/invalid_id" do
      assert current_xml(invalid_id) == {:error, :not_found}
    end
  end

  test "current_xml with valid id" do
    use_cassette "current_raw/valid_id" do
      {flag, xml} = current_xml(valid_id)

      assert flag == :ok
      
      [station_id_text] = Exmerl.XPath.find(xml, "//station_id/text()")

      assert Record.record?(station_id_text, :xmlText)

      keywordList = Weather.NOAA.xmlText(station_id_text)

      assert keywordList[:value] == 'KAUS'
    end
  end
end
