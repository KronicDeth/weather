defmodule Weather.NOAA.Observation do
  import Weather.NOAA,
         only: [
           find_text: 2
         ]

  #
  # Variables
  #

  @user_agent ["User-agent": "Elixir Kronic.Deth@gmail.com"]

  #
  # Functions
  #

  @doc """
  Gets the raw, unparsed XML for the station's current observation.

  Returns {`:ok`, unparsed_xml} on success.  Returns `{:error, :not_found}` on
  failure.
  """
  @spec current_raw(Weather.Station.t) :: {:error, :not_found}
  @spec current_raw(Weather.Station.t) :: {:ok, String.t}
  def current_raw(%Weather.Station{id: id}) do
    current_raw(id)
  end

  @spec current_raw(String.t) :: {:error, :not_found}
  @spec current_raw(String.t) :: {:ok, String.t}
  def current_raw(station_id) when is_binary(station_id) do
    response = HTTPotion.get(Weather.NOAA.Station.url(station_id), @user_agent)

    if HTTPotion.Response.success? response do
      {:ok, response.body}
    else
      status = case response.status_code do
        404 -> :not_found
      end

      {:error, status}
    end
  end

  @doc """
  Gets the parsed XML for the station's current observation.

  Returns {`:ok`, xmlElement} on success. Returns `{:error`, :not_found}` on
  failure.
  """
  @spec current_xml(Weather.Station.t) :: {:ok, Weather.NOAA.xmlElement}
  @spec current_xml(Weather.Station.t) :: {:error, :not_found}
  def current_xml(%Weather.Station{id: id}) do
    current_xml(id)
  end

  @spec current_xml(String.t) :: {:ok, Weather.NOAA.xmlElement}
  @spec current_xml(String.t) :: {:error, :not_found}
  def current_xml(station_id) when is_binary(station_id) do
    case current_raw(station_id) do
      {:ok, raw} ->
        {:ok, Weather.NOAA.raw_to_xml(raw)}
      {:error, :not_found} ->
        {:error, :not_found}
    end
  end

  @doc """
  Parses `Weather.Observation` from XML fetched from weather.gov.
  """
  @spec from_xml(Weather.NOAA.xmlDocument, temperature: String.t) :: Weather.Observation
  def from_xml(document, options) do
    station = Weather.NOAA.Station.from_xml(document)
    temperature = temperature_from_xml(document, units: options[:temperature])

    %Weather.Observation{
      station: station
    }
  end

  @doc """
  Extracts the `Whether.Temperature` in the given units.  If `:units` are
  `nil`, then the default units, `%Weather.Temperature{}.units` is used. 
  """
  @spec temperature_from_xml(String.t, units: nil) :: Weather.Temperature.t
  def temperature_from_xml(document, units: nil) do
    temperature_from_xml(document, units: %Weather.Temperature{}.units)
  end

  @spec temperature_from_xml(String.t, units: String.t) :: Weather.Temperature.t
  def temperature_from_xml(document, units: units) when is_binary(units) do
    find_text(document, "//temperature_#{String.downcase(units)}")
    |> String.to_float
  end
end
