defmodule Weather.Mixfile do
  use Mix.Project

  def project do
    [
     app: :weather,
     deps: deps,
     elixir: "~> 0.14.3",
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
      {:exvcr, "~> 0.2.0"},
      # exvcr dependency that isn't defined
      {:meck, github: "eproxus/meck"},
      {:httpotion, "~> 0.2.4"},
      # if not declared explicitly, ibrowse.app cannot be found
      {:ibrowse, github: "cmullaparthi/ibrowse"},
      {:timex, "~> 0.9.0"}
    ]
  end
end
