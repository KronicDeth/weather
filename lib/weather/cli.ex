defmodule Weather.CLI do
  @moduledoc """
  Handle the command line parsing.
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(
      argv,
      aliases: [
        h: :help
      ],
      switches: [
        help: :boolean
      ]
    )

    case parse do
      {[help: true], _, _} -> :help
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: weather
    """
    System.halt(0)
  end
end
