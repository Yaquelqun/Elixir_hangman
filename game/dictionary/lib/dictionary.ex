defmodule Dictionary do
  alias Dictionary.Generator

  defdelegate random_word(agent), to: Generator
  defdelegate start(), to: Generator, as: :start_link
end
