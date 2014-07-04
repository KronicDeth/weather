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
      {_, [station]} -> station
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: weather <station>
    """
    System.halt(0)
  end

  def process(station) do
    Weather.NOAA.fetch(station)
  end
end
