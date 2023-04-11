# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     IfscService.Repo.insert!(%IfscService.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

IfscService.Repo.delete_all(IfscService.IfscData.Bank)

# File.read!(Application.get_env(:ifsc_service, :ifsc_file_path, "./ifsc.txt"))
# |> ExCsv.parse!(delimiter: '\t')
# |> ExCsv.with_headings(["bank", "ifsc", "branch", "address", "city1", "city2", "state"])
# |> ExCsv.as(IfscService.IfscData.Bank)
# |> Enum.to_list()
# |> Enum.drop(1)
# |> Enum.map(fn bank -> IfscService.IfscData.create_bank(Map.from_struct(bank)) end)

"./ifsc.txt"
|> File.stream!([:line, :read_ahead, 1024])
|> Enum.drop(1)
|> Enum.map(fn x -> String.replace(x, ~s("), "") end)
|> CSV.decode!(separator: ?\t, escape_character: ?")
|> Enum.map(fn x ->
  case x do
    [bank, ifsc, branch, address, city1, city2, state] ->
      IfscService.IfscData.create_bank(%{
        "bank" => bank,
        "ifsc" => ifsc,
        "branch" => branch,
        "address" => address,
        "city1" => city1,
        "city2" => city2,
        "state" => state
      })

    _ ->
      IO.inspect(x)
  end
end)
