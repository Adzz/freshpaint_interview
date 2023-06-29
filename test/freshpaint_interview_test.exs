defmodule FreshpaintInterviewTest do
  use ExUnit.Case
  doctest FreshpaintInterview

  @truthy_results [
    {"", ""},
    {"a", "a"},
    {"a?", ""},
    {"a?", "a"},
    {"a?bc?d", "abd"},
    {"aa?a", "aa"},
    {"aa?a", "aaa"},
    {"abc", "abc"},
    # Added by me:
    {"a?a?", "aa"},
    {"a?a?", ""},
    {"a?a?", "a"},
    {"a?a?bcd", "abcd"},
    {"a?a?bcd", "bcd"},
    {"a?a?bcd", "aabcd"}
  ]
  @falsey_results [
    {"", "abc"},
    {"a", "b"},
    {"a?", "ab"},
    {"a?", "b"},
    {"a?bc?d", "acd"},
    {"a?bc?d", "bbd"},
    {"aa?a", "aaab"},
    {"ab", "abc"},
    {"abc", ""},
    {"abc", "a"},
    {"abc", "bc"},
    {"def", "de"}
  ]

  for {pattern, string} <- @truthy_results do
    test "#{pattern} matches #{string}" do
      assert FreshpaintInterview.matches(unquote(pattern), unquote(string)) == true
    end
  end

  for {pattern, string} <- @falsey_results do
    test "#{pattern} matches #{string}" do
      assert FreshpaintInterview.matches(unquote(pattern), unquote(string)) == false
    end
  end
end
