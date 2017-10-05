defmodule HyperEx.Mixfile do
  use Mix.Project

  @version "0.3.0"

  def project do
    [
      app: :hyper_ex,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      description: "A YAML front matter parser for Elixir.",
       package: package(),
       deps: deps(),
       docs: [extras: ["README.md"],
              main: "readme",
              source_ref: "v#{@version}",
              source_url: "https://github.com/sebastiandedeyne/hyper_ex"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  defp package do
    [name: :hyper_ex,
     files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
     maintainers: ["Sebastian De Deyne"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/sebastiandedeyne/hyper_ex"}]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
