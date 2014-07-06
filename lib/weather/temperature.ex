defmodule Weather.Temperature do
  @moduledoc """
  A temperature in `degrees` along with the `unite` of the `degrees`.
  Supported `units` are `"F"` for Fahrenheit and `"C"` for Celsius.

  Temperatures can be converted between the two units using the conversion
  functions: `to_celsius/1` and `to_fahrenheit/1`.  Conversion function called
  on temperatures already in the target `units` return the given temperature.
  """

  defstruct degrees: 0.0 :: float,
            units: "F" :: String.t

  @spec to_celsius(t) :: t
  def to_celsius(temperature = %Weather.Temperature{units: "C"}) do
    temperature
  end

  @doc """
  Returns the temperature converted to Celsius.
  """
  def to_celsius(%Weather.Temperature{degrees: degrees_fahrenheit, units: "F"}) do
    %Weather.Temperature{
      degrees: (degrees_fahrenheit - 32) * 5.0 / 9.0,
      units: "C"
    }
  end

  @doc """
  Returns the temperature converted to Fahrenheit.
  """
  @spec to_fahrenheit(t) :: t
  def to_fahrenheit(%Weather.Temperature{degrees: degrees_celsius, units: "C"}) do
    %Weather.Temperature{
      degrees: (degrees_celsius * 9.0 / 5.0) + 32,
      units: "F"
    }
  end

  def to_fahrenheit(temperature = %Weather.Temperature{units: "F"}) do
    temperature
  end
end
