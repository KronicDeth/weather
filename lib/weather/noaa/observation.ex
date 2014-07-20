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
  Gets the current observation for the station.

  Returns {:ok, Weather.Observation} on success.  Returns
  `{:error, :not_found} on failure.
  """
  def current(station_or_station_id, options \\ [])

  @spec current(Weather.Station.t, temperature: String.t) :: {:error, :not_found}
  @spec current(Weather.Station.t, temperature: String.t) :: {:ok, Weather.Observation.t}
  def current(%Weather.Station{id: id}, options) do
    current(id, options)
  end

  @spec current(String.t, temperature: String.t) :: {:error, :not_found}
  @spec current(String.t, temperature: String.t) :: {:ok, Weather.Obseravation.t}
  def current(station_id, options) when is_binary(station_id) do
    case current_xml(station_id) do
      {:ok, xmlElement} ->
        {:ok, from_xml(xmlElement, options)}
      error = {:error, _} ->
        error
    end
  end

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
  @spec from_xml(Weather.NOAA.xmlElement, temperature: String.t) :: Weather.Observation.t
  def from_xml(current_observation_element, options) do
    station = Weather.NOAA.Station.from_xml(current_observation_element)
    temperature = temperature_from_xml(
      current_observation_element,
      units: options[:temperature]
    )

    %Weather.Observation{
      station: station,
      temperature: temperature
    }
  end

  @doc """
  Extracts the `Whether.Temperature` in the given units.  If `:units` are
  `nil`, then the default units, `%Weather.Temperature{}.units` is used. 
  """
  @spec temperature_from_xml(Weather.NOAA.xmlElement, units: nil) :: Weather.Temperature.t
  def temperature_from_xml(current_observation_element, units: nil) do
    temperature_from_xml(
      current_observation_element,
      units: %Weather.Temperature{}.units
    )
  end

  @spec temperature_from_xml(Weather.NOAA.xmlElement, units: String.t) :: Weather.Temperature.t
  def temperature_from_xml(current_observation_element, units: units) when is_binary(units) do
    degrees = current_observation_element
    |> find_text("//temp_#{String.downcase(units)}")
    |> String.to_float

    %Weather.Temperature{degrees: degrees, units: units}
  end
end
