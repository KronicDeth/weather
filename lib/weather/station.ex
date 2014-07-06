defmodule Weather.Station do
  @moduledoc """
  A weather station making `Weather.Observation`s.  The `id` is usually call
  sign letters, like `"KAUS"`.  `location` is human-readable description of the
  station's location.  `latitude` is the latitude of the station.  `longitude`
  is the longitude of the station. 
  """
  defstruct id: "" :: String.t,
            location: "" :: String.t,
            latitude: 0.0 :: float,
            longitude: 0.0 :: float
end
