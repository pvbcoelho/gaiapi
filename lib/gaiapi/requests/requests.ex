defmodule Gaiapi.Requests.Requests do
  use Ecto.Schema

  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__, :inserted_at, :updated_at]}
  @primary_key {:request_id, :binary_id, autogenerate: true}
  @required_params [:response, :key, :service_name, :url, :method, :headers, :status_code]

  schema "requests" do
    field(:body, :string)
    field(:response, :string)
    field(:headers, :string)
    field(:key, :string)
    field(:service_name, :string)
    field(:url, :string)
    field(:method, :string)
    field(:status_code, :integer)

    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_params ++ [:body])
    |> validate_required(@required_params)
  end
end
