defmodule PhxSvg.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/drowzy/phx_svg"
  @description "Precompiled svgs for your phoenix project"

  def project do
    [
      app: :phx_svg,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      description: @description,
      package: package(),
      docs: docs(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end


  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}"
    ]
  end

  defp package do
    [
      maintainers: ["Simon Thörnqvist"],
      licenses: ["MIT"],
      files: ~w(
        mix.exs
        README.md
        lib/
        LICENSE
        .formatter.exs
      ),
      links: %{"GitHub" => @source_url}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:floki, "~> 0.34.0"},
      {:phoenix_live_view, "~> 0.18.2", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
