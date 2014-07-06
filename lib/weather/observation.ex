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

  defstruct dewpoint: %Weather.Temperature{} :: Weather.Temperature.t,
            heat_index: %Weather.Temperature{} :: Weather.Temperature.t,
            pressure: %Weather.Pressure{} :: Weather.Pressure.t,
            relative_humidity: 0 :: integer,
            station: %Weather.Station{} :: Weather.Station.t,
            temperature: %Weather.Temperature{} :: Weather.Temperature.t,
            date: nil :: Timex.Date.t ,
            visibility: %Weather.Distance{},
            weather: "Clear" :: String.t,
            wind: %Weather.Wind{} :: Weather.Wind.t
end
