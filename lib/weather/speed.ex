defmodule Weather.Speed do
  @moduledoc """
  A speed's `magnitude` along with the `units of the `magnitude`.  Supported
  `units` are "knots" for knots and "mph" for miles per hour.

  Speeds can be converted between the two units using the conversion functions:
  `to_knots/1`, `to_mph/1`.  Conversion functions called on speeds already in
  the target `units` return the given speed.
  """

  defstruct magnitude: 0.0 :: float,
            units: "mph" :: String.t

  @mph_per_knot 1.15077945

  @spec to_knots(t) :: t
  def to_knots(speed = %Weather.Speed{units: "knots"}), do: speed

  @doc """
  Returns the speed converted to knots.
  """
  def to_knots(%Weather.Speed{magnitude: mph, units: "mph"}) do
    %Weather.Speed{magnitude: mph / @mph_per_knot, units: "knots"}
  end

  @doc """
  Returns the speed converted to mph.
  """
  @spec to_mph(t) :: t
  def to_mph(%Weather.Speed{magnitude: knots, units: "knots"}) do
    %Weather.Speed{magnitude: knots * @mph_per_knot, units: "mph"}
  end

  def to_mph(speed = %Weather.Speed{units: "mph"}) do
    speed
  end
end
