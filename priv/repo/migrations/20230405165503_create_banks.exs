defmodule IfscService.Repo.Migrations.CreateBanks do
  use Ecto.Migration

  def change do
    create table(:banks) do
      add :bank, :string
      add :ifsc, :string
      add :branch, :string
      add :address, :string
      add :city1, :string
      add :city2, :string
      add :state, :string

      timestamps()
    end
  end
end
