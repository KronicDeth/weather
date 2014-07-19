defmodule Weather.Observation do
  @moduledoc """
  An observation made at a `station` (`Weather.Station`).

  ## Observables
  * temperatures
  * `pressure`
  * `relative_humidity`
  * `visibility`
  * `weather`
  * `wind`

  ### Temperatures
  3 temperatures are included in an observation:

  1. The base `temperature`
  2. The `dewpoint`, which is the temperature at which water condenses to dew.
  3. The `heat_index`, which is effective temperature felt by people due to
     the combination of the `temperature` and `relative_humidity`.
  """

  defstruct dewpoint: %Weather.Temperature{},
            heat_index: %Weather.Temperature{},
            pressure: %Weather.Pressure{},
            relative_humidity: 0,
            station: %Weather.Station{},
            temperature: %Weather.Temperature{},
            date: nil,
            visibility: %Weather.Distance{},
            weather: "Clear",
            wind: %Weather.Wind{}
  @type t :: %Weather.Observation{
    dewpoint: Weather.Temperature.t,
    heat_index: Weather.Temperature.t,
    pressure: Weather.Pressure.t,
    relative_humidity: integer,
    station: Weather.Station.t,
    temperature: Weather.Temperature.t,
    date: Timex.Date.t,
    visibility: Weather.Distance.t,
    weather: String.t,
    wind: Weather.Wind.t
  }
end
