defmodule JsonApiClient.Middleware.HTTPClient do
  @moduledoc """
  HTTP client Middleware based on HTTPoison library.
  """

  @behaviour JsonApiClient.Middleware

  alias JsonApiClient.{Request, RequestError, Response}

  @impl JsonApiClient.Middleware
  def call(%Request{} = req, _, _) do
    url = Request.get_url(req)

    headers =
      req.headers
      |> Enum.into([])

    http_options =
      req.options
      |> Map.put(:params, Request.get_query_params(req))
      |> Enum.into([])

    body = Request.get_body(req)

    case HTTPoison.request(req.method, url, body, headers, http_options) do
      {:ok, response} ->
        {:ok, %Response{
          status: response.status_code,
          headers: response.headers,
          doc: response.body
        }}

      {:error, error} ->
        {:error, %RequestError{
          original_error: error,
          message: "Error completing HTTP request: #{error.reason}"
        }}
    end
  end
end
