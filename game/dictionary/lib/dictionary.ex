defmodule Dictionary do
  alias Dictionary.Generator

  defdelegate random_word(), to: Generator
end
