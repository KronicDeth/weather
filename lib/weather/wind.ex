defmodule Weather.Wind do
  defstruct degrees: 90.0 :: float,
            direction: "East" :: String.t,
            speed: %Weather.Speed{} :: Weather.Speed.t
end
