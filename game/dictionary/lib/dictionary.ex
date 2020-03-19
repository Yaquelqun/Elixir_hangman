defmodule Dictionary do
  alias Dictionary.Generator

  defdelegate start(), to: Generator, as: word_list()
  defdelegate random_word(words), to: Generator
end
