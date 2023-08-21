defmodule GaiapiWeb.FallbackController do
  use GaiapiWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> json(%{error: "Request not found"})
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: message})
  end

  def call(conn, error) do
  IO.inspect(error)
    conn
    |> put_status(:bad_request)
    |> json(%{error: "message"})
  end

end
