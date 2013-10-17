defmodule Minion.Mixfile do
  use Mix.Project

  def project do
    [ app: :minion,
      version: "0.0.2",
      name: "Minion",
      source_url: "https://github.com/BananaLtd/minion",
      homepage_url: "http://bananaltd.github.io/minion/",
      elixir: "~> 0.10.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
  [ registered: [:minion],
    mod: { Minion, [] } ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [ { :ex_doc, github: "elixir-lang/ex_doc" },
      { :random, github: "mururu/elixir-random" },
      { :json, "0.2.3", [github: "cblage/elixir-json", tag: "v0.2.3"] } ]
  end
end
