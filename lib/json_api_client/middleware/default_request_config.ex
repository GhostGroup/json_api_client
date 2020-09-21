defmodule JsonApiClient.Middleware.DefaultRequestConfig do
  @moduledoc """
  Adds default headers and options to the request.
  """

  @behaviour JsonApiClient.Middleware

  @version JsonApiClient.Mixfile.project()[:version]
  @package_name JsonApiClient.Mixfile.project()[:app]

  alias JsonApiClient.Request

  @impl JsonApiClient.Middleware
  def call(%Request{} = request, next, _) do
    headers = Map.merge(default_headers(), request.headers)
    http_options = Map.merge(default_options(), request.options)

    next.(%Request{request | headers: headers, options: http_options})
  end

  defp default_headers do
    %{
      "Accept" => "application/vnd.api+json",
      "Content-Type" => "application/vnd.api+json",
      "User-Agent" => user_agent()
    }
  end

  defp default_options do
    %{
      timeout: timeout(),
      recv_timeout: timeout()
    }
  end

  defp user_agent do
    [@package_name, @version, user_agent_suffix()]
    |> Enum.reject(&is_nil/1)
    |> Enum.join("/")
  end

  defp user_agent_suffix do
    Application.get_env(:json_api_client, :user_agent_suffix, "")
  end

  defp timeout do
    Application.get_env(:json_api_client, :timeout, 500)
  end
end
