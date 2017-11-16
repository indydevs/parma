defmodule Parma.RepositoryView do
    use Parma.Web, :view

    def repositories(user_repositories) do
        repo_meta =
        user_repositories
        |> Enum.map(fn(repo) ->
            meta = repo |> Map.get(:meta)
            %{
                id: repo.id,
                enabled: repo.enabled,
                name: repo.name,
                admin: meta |> Map.get("permissions") |> Map.get("admin")
            }
           end)
    end

    def repository_switch_control(repo) do
        attributes = %{
            "type" => "checkbox",
            "id" => repo.id,
            "class" => "repo-switch",
            "data-toggle" => "toggle",
            "data-size" => "small",
            "data-on" => "Enabled",
            "data-off" => "Disabled"
        }

        if repo.enabled, do: attributes = Map.merge(attributes, %{checked: ""})

        tag(:input, attributes |> Map.to_list)
    end

    def render("update_success.json", _assigns) do
        %{status: 200, message: "Repository updated"}
    end
    def render("scripts.index.html", _assigns) do
        ~E(<script src="/page_scripts/repositories.js"></script>)
    end
  end
