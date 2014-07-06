defmodule Weather.Wind do
  @moduledoc """
  The wind heading in `degrees`, `direction`, and `speed`.
  """

  defstruct degrees: 90.0 :: float,
            direction: "East" :: String.t,
            speed: %Weather.Speed{} :: Weather.Speed.t
end
