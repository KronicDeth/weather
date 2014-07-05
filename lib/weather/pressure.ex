defmodule Weather.Pressure do
  defstruct magnitude: 0, units: "in Hg"

  def to_in_hg(pressure = %Weather.Pressure{units: "in Hg"}) do
    pressure
  end

  def to_in_hg(%Weather.Pressure{magnitude: millibars, units: "mb"}) do
    %Weather.Pressure{magnitude: millibars * 0.02955301, units: "in Hg"}
  end

  def to_mb(%Weather.Pressure{magnitude: in_hg, units: "in Hg"}) do
    %Weather.Pressure{magnitude: in_hg * 33.8637526, units: "mb"}
  end

  def to_mb(pressure = %Weather.Pressure{units: "mb"}), do: pressure
end
