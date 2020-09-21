defmodule JsonApiClient.Parser.FieldValidation do
  @moduledoc false

  def valid?(name, field_definition, data) do
    Enum.reduce_while(to_validate(name, field_definition), :ok, fn validation, _ ->
      case validate_fields(validation[:fields], validation[:method], data, validation[:error]) do
        {:ok} -> {:cont, {:ok}}
        error -> {:halt, error}
      end
    end)
  end

  defp to_validate(name, field_definition) do
    either_fields = field_definition[:either_fields] || []
    required_fields = field_definition[:required_fields] || []

    [
      %{
        fields: either_fields,
        method: &validate_either_fields/2,
        error: "A '#{name}' MUST contain at least one of the following members: #{Enum.join(either_fields, ", ")}"
      },
      %{
        fields: required_fields,
        method: &validate_required_fields/2,
        error: "A '#{name}' MUST contain the following members: #{Enum.join(required_fields, ", ")}"
      }
    ]
  end

  defp validate_fields(fields, method, data, error) do
    if !Enum.any?(fields) || method.(fields, data) do
      {:ok}
    else
      {:error, error}
    end
  end

  def validate_required_fields(fields, data) do
    Enum.all?(fields, &Map.has_key?(data, &1))
  end

  def validate_either_fields(fields, data) do
    Enum.any?(fields, &Map.has_key?(data, &1))
  end
end
