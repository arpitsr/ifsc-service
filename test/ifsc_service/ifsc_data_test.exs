defmodule IfscService.IfscDataTest do
  use IfscService.DataCase

  alias IfscService.IfscData

  describe "banks" do
    alias IfscService.IfscData.Bank

    import IfscService.IfscDataFixtures

    @invalid_attrs %{address: nil, bank: nil, branch: nil, city1: nil, city2: nil, ifsc: nil, state: nil}

    test "list_banks/0 returns all banks" do
      bank = bank_fixture()
      assert IfscData.list_banks() == [bank]
    end

    test "get_bank!/1 returns the bank with given id" do
      bank = bank_fixture()
      assert IfscData.get_bank!(bank.id) == bank
    end

    test "create_bank/1 with valid data creates a bank" do
      valid_attrs = %{address: "some address", bank: "some bank", branch: "some branch", city1: "some city1", city2: "some city2", ifsc: "some ifsc", state: "some state"}

      assert {:ok, %Bank{} = bank} = IfscData.create_bank(valid_attrs)
      assert bank.address == "some address"
      assert bank.bank == "some bank"
      assert bank.branch == "some branch"
      assert bank.city1 == "some city1"
      assert bank.city2 == "some city2"
      assert bank.ifsc == "some ifsc"
      assert bank.state == "some state"
    end

    test "create_bank/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = IfscData.create_bank(@invalid_attrs)
    end

    test "update_bank/2 with valid data updates the bank" do
      bank = bank_fixture()
      update_attrs = %{address: "some updated address", bank: "some updated bank", branch: "some updated branch", city1: "some updated city1", city2: "some updated city2", ifsc: "some updated ifsc", state: "some updated state"}

      assert {:ok, %Bank{} = bank} = IfscData.update_bank(bank, update_attrs)
      assert bank.address == "some updated address"
      assert bank.bank == "some updated bank"
      assert bank.branch == "some updated branch"
      assert bank.city1 == "some updated city1"
      assert bank.city2 == "some updated city2"
      assert bank.ifsc == "some updated ifsc"
      assert bank.state == "some updated state"
    end

    test "update_bank/2 with invalid data returns error changeset" do
      bank = bank_fixture()
      assert {:error, %Ecto.Changeset{}} = IfscData.update_bank(bank, @invalid_attrs)
      assert bank == IfscData.get_bank!(bank.id)
    end

    test "delete_bank/1 deletes the bank" do
      bank = bank_fixture()
      assert {:ok, %Bank{}} = IfscData.delete_bank(bank)
      assert_raise Ecto.NoResultsError, fn -> IfscData.get_bank!(bank.id) end
    end

    test "change_bank/1 returns a bank changeset" do
      bank = bank_fixture()
      assert %Ecto.Changeset{} = IfscData.change_bank(bank)
    end
  end
end
