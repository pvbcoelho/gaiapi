defmodule Gaiapi.Services.Requests do
  use HTTPoison.Base

  alias Gaiapi.Repo
  alias Gaiapi.Requests.Requests

  def run(body, headers, method, key, service_name, url) do
    build_header_list(headers)
    |> process_request(body, method, url)
    |> create_request(method, key, service_name, url)
  end

  def get_request_by_request_id(request_id) do
    Requests
    |> Repo.get_by(request_id: request_id)
    |> case  do
      nil -> {:error, :not_found}
      request -> {:ok, request}
    end
  end

  defp process_request(headers, body, "post", url) do
    case post(url, Jason.encode!(body), headers) do
      {:ok, response} -> response
      {:error, %HTTPoison.Error{reason: :nxdomain}} -> {:error, "URL not a valid domain"}
      {:error, error} -> {:error, inspect(error)}
    end
  end

  defp process_request(headers, _body, "get", url) do
    case get(url, headers) do
      {:ok, response} -> response
      {:error, %HTTPoison.Error{reason: :nxdomain}} -> {:error, "URL not a valid domain"}
      {:error, error} -> {:error, inspect(error)}
    end
  end

  defp build_header_list(headers) do
    Enum.map(headers, fn %{"key" => key, "value" => value} ->
      {key, value}
    end)
  end

  defp create_request({:error, _} = error, _method, _key, _service_name, _url), do: error

  defp create_request(response, method, key, service_name, url) do
    %{
      "response" => response.body,
      "body" => response.request.body,
      "headers" => inspect(response.request.headers),
      "method" => method,
      "key" => key,
      "service_name" => service_name,
      "status_code" => response.status_code,
      "url" => url
    }
    |> Requests.changeset()
    |> Repo.insert()
  end

end
