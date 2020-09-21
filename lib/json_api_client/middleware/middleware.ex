defmodule JsonApiClient.Middleware do
  @moduledoc """
  The HTTP client middleware behaviour for the library.
  """

  alias JsonApiClient.{Request, RequestError, Response}

  @type request :: Request.t()
  @type response :: Response.t()
  @type error :: RequestError.t()
  @type middleware_result :: {:ok, response} | {:error, error}
  @type options :: any

  @doc ~S"""
  Manipulates a Request and Response objects.
  If the Request should be processed by the next middleware then `next.(request)` has to be called.

  Args:

  * `request` - JsonApiClient.Request that holds http request properties.

  This function returns `{:ok, response}` if the request is successful, `{:error, reason}` otherwise.
  `response` - HTTP response with the following properties:
    - `body` - body as JSON string.
    - `status_code`- HTTP Status code
    - `headers`- HTTP headers (e.g., `[{"Accept", "application/json"}]`)

  """
  @callback call(request, (request -> middleware_result), options) :: middleware_result
end
