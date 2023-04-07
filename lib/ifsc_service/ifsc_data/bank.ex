defmodule IfscService.IfscData.Bank do
  use Ecto.Schema
  import Ecto.Changeset
  @derive Jason.Encoder
  schema "banks" do
    field(:address, :string)
    field(:bank, :string)
    field(:branch, :string)
    field(:city1, :string)
    field(:city2, :string)
    field(:ifsc, :string)
    field(:state, :string)

    timestamps()
  end

  @doc false
  def changeset(bank, attrs) do
    bank
    |> cast(attrs, [:bank, :ifsc, :branch, :address, :city1, :city2, :state])
    |> validate_required([:bank, :ifsc, :branch, :address, :city1, :city2, :state])
  end

  defimpl Jason.Encoder, for: IfscService.IfscData.Bank do
    def encode(bank, _opts) do
      Jason.encode!(%{
        address: bank.address,
        bank: bank.bank,
        branch: bank.branch,
        city1: bank.city1,
        city2: bank.city2,
        ifsc: bank.ifsc,
        state: bank.state
      })
    end
  end
end
