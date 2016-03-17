ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Ganondorf.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Ganondorf.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Ganondorf.Repo)

