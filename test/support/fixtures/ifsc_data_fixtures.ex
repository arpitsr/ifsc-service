defmodule IfscService.IfscDataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IfscService.IfscData` context.
  """

  @doc """
  Generate a bank.
  """
  def bank_fixture(attrs \\ %{}) do
    {:ok, bank} =
      attrs
      |> Enum.into(%{
        address: "some address",
        bank: "some bank",
        branch: "some branch",
        city1: "some city1",
        city2: "some city2",
        ifsc: "some ifsc",
        state: "some state"
      })
      |> IfscService.IfscData.create_bank()

    bank
  end
end
