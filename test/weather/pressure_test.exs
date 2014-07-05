defmodule Weather.PressureTest do
  use ExUnit.Case, async: true

  test "to_in_hg with in Hg" do
    pressure_in_in_hg = %Weather.Pressure{magnitude: 29.92, units: "in Hg"}
    assert Weather.Pressure.to_in_hg(pressure_in_in_hg) == pressure_in_in_hg
  end

  test "to_in_hg with mb" do
    pressure_in_mb = %Weather.Pressure{magnitude: 1013.25, units: "mb"}
    assert Weather.Pressure.to_in_hg(pressure_in_mb) == 
            %Weather.Pressure{magnitude: 29.9445873825, units: "in Hg"}
  end

  test "to_mb with in Hg" do
    pressure_in_in_hg = %Weather.Pressure{magnitude: 29.92, units: "in Hg"}
    assert Weather.Pressure.to_mb(pressure_in_in_hg) ==
           %Weather.Pressure{magnitude: 1013.203477792, units: "mb"}
  end

  test "to_mb with mb" do
    pressure_in_mb = %Weather.Pressure{magnitude: 1013.25, units: "mb"}
    assert Weather.Pressure.to_mb(pressure_in_mb) == pressure_in_mb
  end
end
