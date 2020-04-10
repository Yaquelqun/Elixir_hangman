defmodule Demo do 

  def reverse do
    receive do
      { origin, msg } ->
      result = msg |> String.reverse
      send origin, result
      reverse()
    end
  end
end