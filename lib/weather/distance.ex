defmodule Weather.Distance do
  @moduledoc """
  A distance's `magnitude` along with the `units` of the `magnitude`.
  Supported `units` are `"mi"` for miles.
  """

  defstruct magnitude: 0.0,
            units: "mi"
  @type t :: %Weather.Distance{magnitude: float, units: String.t}
end
