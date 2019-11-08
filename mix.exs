defmodule AvroSchema.MixProject do
  use Mix.Project

  def project do
    [
      app: :avro_schema,
      version: "0.1.0",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      source_url: "https://github.com/cogini/avro_schema",
      homepage_url: "https://github.com/cogini/avro_schema",
      deps: deps(),
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
      dialyzer: [
        # plt_add_deps: :project,
        # plt_add_deps: :apps_direct,
        # plt_add_apps: [:ssl, :mnesia, :compiler, :xmerl, :inets, :disk_log],
        plt_add_apps: [:erlavro, :tesla],
        # plt_add_deps: true,
        # flags: ["-Werror_handling", "-Wrace_conditions"],
        # flags: ["-Wunmatched_returns", :error_handling, :race_conditions, :underspecs],
        # ignore_warnings: "dialyzer.ignore-warnings"
      ],
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger] ++ extra_applications(Mix.env())
    ]
  end

  defp extra_applications(:test), do: [:hackney]
  defp extra_applications(_),     do: []

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:confluent_schema_registry, github: "cogini/confluent_schema_registry"},
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:erlavro, "~> 2.8"},
      {:ex_doc, "~> 0.19.2", only: :dev, runtime: false},
      {:excoveralls, "~> 0.12.0", only: [:dev, :test], runtime: false},
    ]
  end

  defp description do
    "Convenience libary for working with Avro schemas and Confluent Schema Registry"
  end

  defp package do
    [
      maintainers: ["Jake Morrison"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/cogini/avro_schema"}
    ]
  end

  defp docs do
    [
      source_url: "https://github.com/cogini/avro_schema",
      extras: ["README.md"]
    ]
  end

end
