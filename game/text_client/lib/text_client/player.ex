defmodule TextClient.Player do

  alias TextClient.{ State, Summary, Prompter, Mover }

  def play(%State{ tally: %{ game_state: :won}}) do
    exit_with_message  "You WON"
  end

  def play(%State{ tally: %{ game_state: :lost}}) do
    exit_with_message "You LOST"
  end

  def play(game = %State{ tally: %{ game_state: :good_guess }}) do
    continue_with_message(game, "Good Guess")
  end

  def play(game = %State{ tally: %{ game_state: :bad_guess }}) do
    continue_with_message(game, "Bad Guess")
  end

  def play(game = %State{ tally: %{ game_state: :already_used }}) do
    continue_with_message(game, "Already used that letter")
  end

  def play(game) do
    continue(game)
  end

  defp continue_with_message(game, message) do
    IO.puts message
    continue game
  end

  defp continue (game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.move()
    |> play()
  end

  defp make_move(game) do
    game
  end

  defp exit_with_message(message) do
    IO.puts(message)
    exit(:normal)
  end

end