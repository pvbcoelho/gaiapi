defmodule Gaiapi.Util.Utils do

  def validate_headers(header_list) do
    Enum.all?(header_list, fn header ->
      is_map(header) and Map.has_key?(header, "key") and Map.has_key?(header, "value")
    end)
    |> if do
      :ok
    else
      {:error, "Invalid headers"}
    end
  end

  def validate_body(_body, "get"), do: :ok
  def validate_body(body, "post") when body in [nil, ""], do: {:error, "Invalid body"}
  def validate_body(_body, _any), do: :ok

  def validate_uuid(uuid) do
    case Ecto.UUID.cast(uuid) do
      :error -> {:error, "not a valid request_id"}
      {:ok, _} -> :ok
    end
  end
end
