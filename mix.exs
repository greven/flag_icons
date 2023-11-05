defmodule FlagIcons.MixProject do
  use Mix.Project

  def project do
    [
      app: :flag_icons,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.30", only: :dev, runtime: false},
      {:phoenix_live_view, ">= 0.18.0"},
      {:req, "~> 0.4"}
    ]
  end
end
