defmodule IfscServiceWeb.BankController do
  use IfscServiceWeb, :controller

  def show(conn, params) do
    %{"ifsc" => ifsc} = params
    bank = IfscService.Repo.get_by!(IfscService.IfscData.Bank, ifsc: String.upcase(ifsc))
    json(conn, %{bank: bank})
  end
end
