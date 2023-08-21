defmodule GaiapiWeb.RequestsController do
  use GaiapiWeb, :controller

  alias Gaiapi.Services.Requests
  alias Gaiapi.Util.Utils

  action_fallback GaiapiWeb.FallbackController

  def create(
        conn,
        %{
          "headers" => headers,
          "method" => method,
          "key" => key,
          "service_name" => service_name,
          "url" => url
        } = params
      ) do
    with :ok <- Utils.validate_headers(headers),
          :ok  <- Utils.validate_body(params["body"], method),
         {:ok, response} <- Requests.run(params["body"], headers, method, key, service_name, url) do
      conn
      |> put_status(:ok)
      |> json(response)
    end
  end

  def get(conn, %{"request_id" => request_id}) do
    with :ok <- Utils.validate_uuid(request_id),
    {:ok, request}  <- Requests.get_request_by_request_id(request_id) do
      conn
      |> put_status(:ok)
      |> json(request)
    end
  end
end
