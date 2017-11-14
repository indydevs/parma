defmodule Parma.RepositoryViewTest do
  use Parma.ConnCase, async: true
  import Parma.Factory

  test "#respositories gives a map of repo name and admin access" do
    repos = build_list(2, :repository)
    expected_result = Enum.map(repos, fn(repo) ->
      %{
          name: repo.name,
          admin: true
      }
    end)

    result = Parma.RepositoryView.repositories(repos)
    assert result == expected_result
  end
end
