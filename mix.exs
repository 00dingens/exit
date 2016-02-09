defmodule Exit.Mixfile do
  use Mix.Project

  def project do
    [app: :eit,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :exometer_core, :exometer_influxdb],
    mod: {Exit, []}]
  end

  defp deps do
    [
      {:conform, "~> 0.16.0"},
      {:relx, "~> 3.5.0" },
      {:meck, github: "eproxus/meck", tag: "0.8.2", override: true},
      {:edown, github: "uwiger/edown", ref: "HEAD", override: true},
      {:exometer_core, github: "Feuerlabs/exometer_core", override: true},
      {:exometer_influxdb, github: "travelping/exometer_influxdb"}
    ]
  end
end
