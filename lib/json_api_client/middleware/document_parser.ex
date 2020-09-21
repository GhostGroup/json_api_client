defmodule JsonApiClient.Middleware.DocumentParser do
  @moduledoc """
  HTTP client JSON API doucment parser.
  """

  @behaviour JsonApiClient.Middleware

  alias JsonApiClient.{Parser, Request, RequestError}

  @impl JsonApiClient.Middleware
  def call(%Request{} = request, next, _options) do
    with {:ok, response} <- next.(request),
         {:ok, parsed} <- parse_response(response) do
      {:ok, parsed}
    end
  end

  defp parse_response(response) do
    with {:ok, doc} <- parse_document(response.doc) do
      {:ok, %{response | doc: doc}}
    else
      {:error, error} ->
        {:error, %RequestError{
          message: "Error Parsing JSON API Document",
          original_error: error,
          status: response.status,
          attributes: response.attributes
        }}
    end
  end

  defp parse_document(""), do: {:ok, nil}

  defp parse_document(json) do
    Parser.parse(json)
  end
end
