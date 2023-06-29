defmodule FreshpaintInterview do
  @optional "?"

  @doc """
  Patterns match exactly, so missing letters matter. A letter can be marked as optional
  with a question mark like so: a?
  """
  # These two cases are not strictly needed - if you remove them it all works. but they
  # short circuit which probably speeds things up in some cases.
  def matches("", ""), do: true
  def matches("", _), do: false

  def matches(patten, string) do
    patten
    |> tokenize([])
    |> match_pattern(string)
  end

  defp match_pattern([], ""), do: true
  defp match_pattern([], _), do: false

  defp match_pattern([{:optional, _char}], ""), do: true

  defp match_pattern(
         [{:optional, optional_char}, {:required, optional_char} | rest_tokens],
         string
       ) do
    # If we see an optional char followed by the same char required, we must see 1 or 2 of
    # those characters exactly.
    case string do
      <<^optional_char::binary-size(1), ^optional_char::binary-size(1)>> ->
        match_pattern(rest_tokens, "")

      <<^optional_char::binary-size(1), ^optional_char::binary-size(1), rest_string::binary>> ->
        match_pattern(rest_tokens, rest_string)

      <<^optional_char::binary-size(1)>> ->
        match_pattern(rest_tokens, "")

      <<^optional_char::binary-size(1), rest_string::binary>> ->
        match_pattern(rest_tokens, rest_string)

      _string ->
        false
    end
  end

  defp match_pattern(
         [{:optional, optional_char}, {:optional, optional_char} | rest_tokens],
         string
       ) do
    # If we see two optional chars, we can see 0, 1 or 2 occurrences of the character.
    case string do
      <<^optional_char::binary-size(1), ^optional_char::binary-size(1)>> ->
        match_pattern(rest_tokens, "")

      <<^optional_char::binary-size(1), ^optional_char::binary-size(1), rest_string::binary>> ->
        match_pattern(rest_tokens, rest_string)

      <<^optional_char::binary-size(1)>> ->
        match_pattern(rest_tokens, "")

      <<^optional_char::binary-size(1), rest_string::binary>> ->
        match_pattern(rest_tokens, rest_string)

      string ->
        match_pattern(rest_tokens, string)
    end
  end

  defp match_pattern(
         [{:optional, optinal_char} | rest_tokens],
         <<char::binary-size(1), rest_string::binary>> = string
       ) do
    if optinal_char == char do
      match_pattern(rest_tokens, rest_string)
    else
      match_pattern(rest_tokens, string)
    end
  end

  defp match_pattern(
         [{:required, required_char} | rest_tokens],
         <<char::binary-size(1), rest_string::binary>>
       ) do
    if required_char == char do
      match_pattern(rest_tokens, rest_string)
    else
      false
    end
  end

  # If we have some tokens left but no string we have not matched...
  defp match_pattern([_ | _], ""), do: false

  defp tokenize("", tokens), do: Enum.reverse(tokens)

  defp tokenize(<<char::binary-size(1), @optional, rest::binary>>, tokens) do
    tokenize(rest, [{:optional, char} | tokens])
  end

  defp tokenize(<<char::binary-size(1), rest::binary>>, tokens) do
    tokenize(rest, [{:required, char} | tokens])
  end
end
