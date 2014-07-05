defmodule Weather.SpeedTest do
  use ExUnit.Case

  test "to_knots with knots" do
    speed_in_knots = %Weather.Speed{magnitude: 10, units: "knots"}
    assert Weather.Speed.to_knots(speed_in_knots) == speed_in_knots
  end

  test "to_knots with mph" do
    speed_in_mph = %Weather.Speed{magnitude: 55, units: "mph"}
    assert Weather.Speed.to_knots(speed_in_mph) ==
           %Weather.Speed{magnitude: 47.79369322245023, units: "knots"}
  end

  test "to_mph with knots" do
    speed_in_knots = %Weather.Speed{magnitude: 10, units: "knots"}
    assert Weather.Speed.to_mph(speed_in_knots) ==
           %Weather.Speed{magnitude: 11.5077945, units: "mph"}
  end

  test "to_mph with mph" do
    speed_in_mph = %Weather.Speed{magnitude: 55, units: "mph"}
    assert Weather.Speed.to_mph(speed_in_mph) ==
           speed_in_mph
  end
end
