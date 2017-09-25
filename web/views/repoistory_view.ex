defmodule Parma.RepositoryView do
    use Parma.Web, :view

    def repositories(user_repositories) do
        require IEx; IEx.pry;
        user_repositories 
        |> Enum.map(fn(repo) -> 
            %{ 
                name: repo.name,
                admin: (repo |> Map.get(:meta) |> Map.get("permissions") |> Map.get("admin"))
            } 
           end)
    end
  end