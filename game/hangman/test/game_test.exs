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

  test "state is not changed for won or lost games" do
    for state <- [:won, :lost] do
      game = Game.new_game |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move( game, "c")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    game = Game.make_move( game, "c")
    assert game.game_state != :already_used
    game = Game.make_move( game, "c")
    assert game.game_state == :already_used
  end

  test "a good guess is recognised" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("test")
    game = Game.make_move(game, "t")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    game = Game.make_move(game, "e")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    game = Game.make_move(game, "s")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "a bad guess is recognised" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "f")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "enough bad guesses is a lost game" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "f")
    game = Game.make_move(game, "r")
    game = Game.make_move(game, "t")
    game = Game.make_move(game, "y")
    game = Game.make_move(game, "u")
    game = Game.make_move(game, "o")
    game = Game.make_move(game, "p")
    assert game.game_state == :lost
  end


  test "a bad input is recognised" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, 23)
    assert game.game_state == :wrong_input
  end
end