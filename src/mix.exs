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
      {:bbmustache, "~> 1.7"},
      {:con_cache, "~> 0.13"},
      {:connection, "~> 1.0"},
      {:cipher, ">= 1.4.0"},
      {:deep_merge, "~> 0.2"},
      {:erlexec, "~> 1.9"},
      {:ex_abci_proto, "~> 0.9"},
      {:ex_abci, "~> 0.8"},
      {:geolix, "~> 0.17"},
      {:grpc, "~> 0.3"},
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.1"},
      {:logger_file_backend, git: "https://github.com/tyrchen/logger_file_backend"},
      {:lqueue, "~> 1.1"},
      {:merkle_patricia_tree, github: "tyrchen/merkle_patricia_tree"},
      {:phoenix_pubsub, "~> 1.1"},
      {:postgrex, "~> 0.13.0", override: true},
      {:protobuf, "~> 0.6"},
      {:rule_parser, "~> 0.2"},
      {:simplehttp, "~> 0.5.1", runtime: false},
      {:toml, "~> 0.6"},
      {:typed_struct, "~> 0.1.4"},
      {:utility_belt, "~> 0.16"},

      # forge sdk
      {:google_protos, "~> 0.1"},
      {:keccakf1600, "~> 2.0", hex: :keccakf1600_orig},
      {:libdecaf, "~> 1.0"},
      {:libsecp256k1, "~> 0.1.3"},
      {:mcrypto, "~> 0.2"},
      {:multibase, "~> 0.0.1"},
      {:recase, "~> 0.6"},
      {:bloom_list, "~> 1.0"},

      # recon
      {:extrace, "~> 0.1"},
      {:recon, "~> 2.4"},

      # time consuming statistics
      {:statix, "~> 1.1"},

      # simulator
      {:nimble_parsec, "~> 0.5"},
      {:poolboy, "~> 1.5"},
      {:slugger, "~> 0.3"},
      {:timex, "~> 3.0"},
      {:yaml_elixir, "~> 2.4"},

      # pheonix and other

      # phoenix
      {:phoenix, "1.4.0"},
      {:phoenix_html, "~> 2.13"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},

      # absinthe
      {:absinthe, "~> 1.4"},
      {:absinthe_phoenix, "~> 1.4"},
      {:absinthe_plug, "~> 1.4"},

      # goldorin
      {:goldorin, "~> 0.41"},

      # forge indexer dep
      {:ecto, "~> 2.2", override: true},
      # {:sqlite_ecto2, "~> 2.2"},
      {:sqlite_ecto2, git: "https://github.com/tyrchen/sqlite_ecto2"},

      # other dependencies
      {:cors_plug, "~> 2.0"},
      {:cowboy, "~> 2.5"},
      {:drab, "~> 0.10.1"},
      {:gettext, "~> 0.16"},
      {:plug, "~> 1.8"},
      {:plug_cowboy, "~> 2.0"},
      {:simple_bitmap, "~> 1.4"},

      # Other dependency
      {:earmark, "~> 1.4"},
      {:sentry, "~> 6.4"},

      # dev & test
      {:benchee, "~> 0.13", only: :dev},
      {:benchee_html, "~> 0.4", only: :dev},
      {:credo, "~> 1.0.0", only: [:dev, :test]},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev, :integration], runtime: false},
      {:ex_doc, "~> 0.19.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.11", only: [:test, :integration]},
      {:faker, "~> 0.11", only: [:dev, :test]},
      {:mock, "~> 0.3", only: [:dev, :test, :integration]},
      {:pre_commit_hook, "~> 1.2", only: [:dev, :test], runtime: false},
      {:stream_data, "~> 0.4", only: [:test, :integration]},
    ]
  end
end
