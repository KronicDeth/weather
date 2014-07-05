defmodule Weather.Pressure do
  @moduledoc """
  A pressure's `magnitude` along with the `units` of the magnitude.  Supported
  `units` are `"in Hg"` for inches mercury and `"mb"` for millibars.

  Pressures can be converted between the two units using the conversion
  functions: `to_in_hg/1` and `to_mb/1`.  Conversion functions called on
  pressures already in the target `units` return the given pressure.
  """

  defstruct magnitude: 0.0 :: float,
            units: "in Hg" :: String.t

  @spec to_in_hg(t) :: t
  def to_in_hg(pressure = %Weather.Pressure{units: "in Hg"}) do
    pressure
  end

  @doc """
  Returns the pressure converted to in Hg.
  """
  def to_in_hg(%Weather.Pressure{magnitude: millibars, units: "mb"}) do
    %Weather.Pressure{magnitude: millibars * 0.02955301, units: "in Hg"}
  end

  @doc """
  Returns the pressure converted to mb.
  """
  @spec to_mb(t) :: t
  def to_mb(%Weather.Pressure{magnitude: in_hg, units: "in Hg"}) do
    %Weather.Pressure{magnitude: in_hg * 33.8637526, units: "mb"}
  end

  def to_mb(pressure = %Weather.Pressure{units: "mb"}), do: pressure
end
