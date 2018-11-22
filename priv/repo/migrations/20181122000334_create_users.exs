defmodule Accountable.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :permissions, :map
      add :is_active, :boolean, default: true, null: true

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
