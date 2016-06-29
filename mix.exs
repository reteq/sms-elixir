defmodule Sms.Mixfile do
  use Mix.Project

  def project do
    [app: :sms,
     version: "0.0.1",
     description: "SMS service APIs for Elixir",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
     {:poison, "~> 2.2.0"},
     {:httpoison, "~> 0.9.0"}
    ]
  end

  defp package do
    [
      name: :sms,
      files: ["mix.exs", "lib", "README*", "LICENSE*"],
      maintainers: ["Tsung Wu"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/reteq/sms-elixir"}
    ]
  end
end
