defmodule JsonApiClient do
  @moduledoc """
  A client library for interacting with REST APIs that comply with
  the JSON API spec described at http://jsonapi.org
  """

  alias __MODULE__.Middleware.Runner
  alias __MODULE__.Request

  @doc "Execute a JSON API Request using HTTP GET"
  @spec fetch(req :: Request.t()) :: {:ok, JsonApiClient.Response.t()} | {:error, JsonApiClient.RequestError.t()}
  def fetch(%Request{} = req), do: req |> Request.method(:get) |> execute
  @doc "Error raising version of `fetch/1`"
  @spec fetch!(req :: Request.t()) :: JsonApiClient.Response.t() | no_return
  def fetch!(%Request{} = req), do: req |> Request.method(:get) |> execute!

  @doc "Execute a JSON API Request using HTTP POST"
  @spec create(req :: Request.t()) :: {:ok, JsonApiClient.Response.t()} | {:error, JsonApiClient.RequestError.t()}
  def create(%Request{} = req), do: req |> Request.method(:post) |> execute
  @doc "Error raising version of `create/1`"
  @spec create!(req :: Request.t()) :: JsonApiClient.Response.t() | no_return
  def create!(%Request{} = req), do: req |> Request.method(:post) |> execute!

  @doc "Execute a JSON API Request using HTTP PATCH"
  @spec update(req :: Request.t()) :: {:ok, JsonApiClient.Response.t()} | {:error, JsonApiClient.RequestError.t()}
  def update(%Request{} = req), do: req |> Request.method(:patch) |> execute
  @doc "Error raising version of `update/1`"
  @spec update!(req :: Request.t()) :: JsonApiClient.Response.t() | no_return
  def update!(%Request{} = req), do: req |> Request.method(:patch) |> execute!

  @doc "Execute a JSON API Request using HTTP DELETE"
  @spec delete(req :: Request.t()) :: {:ok, JsonApiClient.Response.t()} | {:error, JsonApiClient.RequestError.t()}
  def delete(%Request{} = req), do: req |> Request.method(:delete) |> execute
  @doc "Error raising version of `delete/1`"
  @spec delete!(req :: Request.t()) :: JsonApiClient.Response.t() | no_return
  def delete!(%Request{} = req), do: req |> Request.method(:delete) |> execute!

  @doc """
  Execute a JSON API Request

  Takes a JsonApiClient.Request and preforms the described request.

  Returns either a tuple with `:ok` and a `JsonApiClient.Response` struct (or
  nil) or `:error` and a `JsonApiClient.RequestError` struct depending on the
  http response code and whether the server response was valid according to the
  JSON API spec.

  | Scenario     | Server Response Valid | Return Value                                                                         |
  |--------------|-----------------------|--------------------------------------------------------------------------------------|
  | 2**          | yes                   | `{:ok, %Response{status: 2**, doc: %Document{}}`                                     |
  | 4**          | yes                   | `{:ok, %Response{status: 4**, doc: %Document{} or nil}`                              |
  | 5**          | yes                   | `{:ok, %Response{status: 5**, doc: %Document{} or nil}`                              |
  | 2**          | no                    | `{:error, %RequestError{status: 2**, message: "Invalid response body"}}`             |
  | 4**          | no                    | `{:ok, %Response{status: 4**, doc: nil}}`                                            |
  | 5**          | no                    | `{:ok, %Response{status: 3**, doc: nil}}`                                            |
  | socket error | n/a                   | `{:error, %RequestError{status: nil, message: "Error completing HTTP request econnrefused", original_error: error}}` |

  """
  @spec execute(req :: Request.t()) :: {:ok, JsonApiClient.Response.t()} | {:error, term}
  def execute(%Request{} = req) do
    Runner.run(req)
  end

  @doc "Error raising version of `execute/1`"
  @spec execute!(req :: Request.t()) :: JsonApiClient.Response.t() | no_return()
  def execute!(%Request{} = req) do
    case execute(req) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
