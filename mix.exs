defmodule Alipay.Mixfile do
  use Mix.Project

  def project do
    [app: :alipay,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.10.0"}, {:poison, "~> 3.0"}]
  end

  defp description do
    """
    This is Alipay Elixir SDK.
    """
  end

  defp package do
    [
     name: :alipay,
     files: ["lib", "mix.exs", "README*", "LICENSE*", "test", "config"],
     maintainers: ["davidqhr"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/davidqhr/elixir-alipay",
              "Docs" => "https://github.com/davidqhr/elixir-alipay"}]
  end
end