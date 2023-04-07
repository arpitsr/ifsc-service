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

File.read!(Application.get_env(:ifsc_service, :ifsc_file_path, "./ifsc.txt"))
|> ExCsv.parse!(delimiter: '\t')
|> ExCsv.with_headings(["bank", "ifsc", "branch", "address", "city1", "city2", "state"])
|> ExCsv.as(IfscService.IfscData.Bank)
|> Enum.to_list()
|> Enum.drop(1)
|> Enum.map(fn bank -> IfscService.IfscData.create_bank(Map.from_struct(bank)) end)
