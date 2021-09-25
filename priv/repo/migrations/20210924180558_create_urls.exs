defmodule Suse.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :long_url, :text, nil: false
      add :slug, :string, nil: false

      timestamps()
    end
  end
end
