defmodule Sequence.Mixfile do
  use Mix.Project

  # ...

  def project do
    [ app: :sequence,
      version: "0.0.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Sequence, 456 },
      registered: [ Sequence.Server ]
    ]
  end

  defp deps do
    []
  end
end