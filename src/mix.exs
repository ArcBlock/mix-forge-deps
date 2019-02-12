defmodule MixDeps.MixProject do
  use Mix.Project

  @version File.cwd!() |> Path.join("../version") |> File.read!() |> String.trim()
  @elixir_version File.cwd!() |> Path.join(".elixir_version") |> File.read!() |> String.trim()

  def project do
    [
      app: :mix_deps,
      version: @version,
      elixir: @elixir_version,
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
      {:con_cache, "~> 0.13"},
      {:connection, "~> 1.0"},
      {:deep_merge, "~> 0.1.1"},
      {:erlexec, "~> 1.9"},
      {:ex_abci_proto, "~> 0.7.6"},
      {:ex_abci, "~> 0.7.6"},
      {:geolix, "~> 0.17"},
      {:grpc, "~> 0.3"},
      {:httpoison, "~> 1.5"},
      {:jason, "~> 1.1"},
      {:lqueue, "~> 1.1"},
      {:merkle_patricia_tree, github: "tyrchen/merkle_patricia_tree"},
      {:phoenix_pubsub, "~> 1.1"},
      {:toml, "~> 0.5"},
      {:typed_struct, "~> 0.1.4"},

      # forge sdk
      {:google_protos, "~> 0.1"},
      {:keccakf1600, "~> 2.0", hex: :keccakf1600_orig},
      {:libdecaf, "~> 1.0"},
      {:libsecp256k1, "~> 0.1.3"},
      {:mcrypto, "~> 0.1.0"},
      {:multibase, "~> 0.0.1"},
      {:recase, "~> 0.4"},

      # simulator
      {:nimble_parsec, "~> 0.5"},
      {:poolboy, "~> 1.5"},
      {:slugger, "~> 0.3"},
      {:timex, "~> 3.0"},
      {:yaml_elixir, "~> 2.1"},

      # pheonix and other

      # phoenix
      {:phoenix, "~> 1.4"},
      {:phoenix_html, "~> 2.13"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},

      # absinthe
      {:absinthe, "~> 1.4"},
      {:absinthe_phoenix, "~> 1.4"},
      {:absinthe_plug, "~> 1.4"},

      # goldorin
      {:goldorin, "~> 0.39"},

      # forge indexer dep
      {:ecto, "~> 2.2", override: true},
      {:sqlite_ecto2, "~> 2.2"},

      # other dependencies
      {:cors_plug, "~> 2.0"},
      {:cowboy, "~> 2.5"},
      {:drab, "~> 0.10.1"},
      {:gettext, "~> 0.16"},
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"},

      # Other dependency
      {:earmark, "~> 1.3"},

      # dev & test
      {:benchee, "~> 0.13", only: :dev},
      {:benchee_html, "~> 0.4", only: :dev},
      {:credo, "~> 1.0.0", only: [:dev, :test]},
      {:dialyxir, "~> 1.0.0-rc.4", only: [:dev, :integration], runtime: false},
      {:ex_doc, "~> 0.19.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: [:test, :integration]},
      {:faker, "~> 0.11", only: [:dev, :test]},
      {:mock, "~> 0.3.0", only: [:dev, :test, :integration]},
      {:pre_commit_hook, "~> 1.2", only: [:dev, :test], runtime: false},
      {:stream_data, "~> 0.4", only: [:test, :integration]},

      # deployment
      {:distillery, "~> 2.0", runtime: false}
    ]
  end
end
