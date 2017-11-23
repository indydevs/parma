defmodule Parma.Factory do
    use ExMachina.Ecto, repo: Parma.Repo

    def application_factory do
        %Parma.Application{
            name: Faker.Company.name
        }
    end

    def user_factory do
        %Parma.User{
            name: Faker.Name.name(),
            email: Faker.Internet.email(),
        }
    end

    def repository_factory do
        %Parma.Repository{
            name: Faker.Company.buzzword(),
            meta: %{"permissions" => %{"admin" => true }},
            enabled: true,
            source_id: sequence(:source_id, &("#{&1}")),
            application: build(:application)
        }
    end

    def authorization_factory do
        %Parma.Authorization{
            user: build(:user),
            provider: "github",
            uid: sequence(:uid, &"uid-#{&1}"),
            token: SecureRandom.base64(16),
            refresh_token: SecureRandom.base64(16),
            expires_at: DateTime.utc_now |> DateTime.to_unix
        }
    end

    def user_with_repositories(repo_count \\ 2, opts \\ []) do
        opts = opts ++ [repositories: build_list(repo_count, :repository)]
        insert(:user, opts)
    end
end
