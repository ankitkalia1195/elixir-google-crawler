defmodule GoogleCrawler.Repo.Migrations.CreateKeywords do
  use Ecto.Migration

  def change do
    create table(:keywords) do
      add :name, :string, null: false
      add :status, :integer, default: 0, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:keywords, [:user_id])
    create index(:keywords, [:user_id, :name])
    create index(:keywords, [:user_id, :status])
  end
end
