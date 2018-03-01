defmodule Maplist.Mixfile do
  use Mix.Project

  def project do
    [
      app: :maplist,
      version: "0.1.0",
      elixir: "~> 1.5-rc",
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/nikbad/maplist"
    ]
  end

  defp description() do
    "Functions that simplify operations with lists of maps."
  end

defp package() do
  [
    # These are the default files included in the package
    files: ["lib", "mix.exs", "README*"],
    maintainers: ["NikBad"],
    licenses: ["MIT"],
    links: %{"GitHub" => "https://github.com/nikbad/maplist"}
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
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
    ]
  end
end
