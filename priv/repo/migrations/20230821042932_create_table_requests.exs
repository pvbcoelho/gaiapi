defmodule Gaiapi.Repo.Migrations.CreateTableRequests do
  use Ecto.Migration

  def change do
    create table(:requests, primary_key: false) do
      add(:request_id, :uuid, primary_key: true)
      add(:body, :text)
      add(:headers, :text, null: false)
      add(:response, :text, null: false)
      add(:key, :string, null: false)
      add(:service_name, :string, null: false)
      add(:url, :string, null: false)
      add(:method, :string, null: false)
      add(:status_code, :integer, null: false)

      timestamps()
    end
  end
end
