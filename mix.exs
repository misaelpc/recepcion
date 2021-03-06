defmodule Reception.Mixfile do
  use Mix.Project

  def project do
    [app: :reception,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Reception, []},
     applications: [:phoenix, :cowboy, :logger, :postgrex, :ecto, :xmerl, :crypto]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.9.0"},
     {:cowboy, "~> 1.0"},
     {:postgrex, "~> 0.6.0"},
     {:ecto, "~> 0.5.1"},
     {:exrm, "~> 0.15.0"},
     {:chronos, "~> 0.3.5"},
     {:uuid, "~> 0.1.5"}]
  end
end
