defmodule GameTest do
  use ExUnit.Case
  alias Hangman.Game

  test "new_game" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    Enum.each(game.letters, fn letter ->
      assert(letter >= "a")
      assert(letter <= "z")
      end
    )
  end
end
