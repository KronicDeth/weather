defmodule Weather.TemperatureTest do
  use ExUnit.Case

  test "to_celsius with Celsius" do
    temperature_in_celsius = %Weather.Temperature{degrees: 0, units: "C"}
    assert Weather.Temperature.to_celsius(temperature_in_celsius) ==
           temperature_in_celsius
  end

  test "to_celsius with Fahrenheit" do
    temperature_in_fahrenheit = %Weather.Temperature{degrees: 32, units: "F"}
    assert Weather.Temperature.to_celsius(temperature_in_fahrenheit) ==
           %Weather.Temperature{degrees: 0.0, units: "C"}
  end

  test "to_fahrenheit with Celsius" do
    temperature_in_celsius = %Weather.Temperature{degrees: 0, units: "C"}
    assert Weather.Temperature.to_fahrenheit(temperature_in_celsius) ==
           %Weather.Temperature{degrees: 32.0, units: "F"}
  end

  test "to_fahrenheit with Fahrenheit" do
    temperature_in_fahrenheit = %Weather.Temperature{degrees: 32, units: "F"}
    assert Weather.Temperature.to_fahrenheit(temperature_in_fahrenheit) ==
           temperature_in_fahrenheit
  end
end
