defmodule JsonApiClient.Middleware.Runner do
  @moduledoc false

  alias JsonApiClient.Middleware.Factory
  @spec run(request :: JsonApiClient.Request.t()) :: JsonApiClient.Middleware.middleware_result
  def run(%JsonApiClient.Request{} = request) do
    middleware_runner(Factory.middlewares()).(request)
  end

  defp middleware_runner([]) do
  end

  defp middleware_runner([{middleware, options} | rest]) do
    fn request ->
      middleware.call(request, middleware_runner(rest), options)
    end
  end
end
