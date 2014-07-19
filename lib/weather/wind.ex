defmodule Weather.Wind do
  @moduledoc """
  The wind heading in `degrees`, `direction`, and `speed`.
  """

  defstruct degrees: 90.0,
            direction: "East",
            speed: %Weather.Speed{}
  @type t :: %Weather.Wind{
    degrees: float,
    direction: String.t,
    speed: Weather.Speed.t
  }
end
