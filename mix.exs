defmodule Weather.Mixfile do
  use Mix.Project

  def project do
    [
     app: :weather,
     deps: deps,
     elixir: "~> 0.14.0",
     name: "Weather",
     source_url: "https://github.com/KronicDeth/weather",
     version: "0.0.1"
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:httpotion]]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:ex_doc, github: "elixir-lang/ex_doc"},
      {:exmerl, "~> 0.1.1"},
      {:httpotion, github: "myfreeweb/httpotion"}
    ]
  end
end
