require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if board.over? == true && board.winner != @next_mover_mark

  end

  def winning_node?(evaluator)
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @rows[row][col]
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_pos = []
    (0..2).each do |i|
      (0..2).each do |j|
        if @board.empty?([i,j])
          empty_pos << [i,j]
        end
      end
    end

    children = []
    @next_mover_mark == :x ? @next_mover_mark = :o : @next_mover_mark = :x
    empty_pos.each do |pos|
      temp_board = @board.dup

      temp_board[pos] = @next_mover_mark

      children << TicTacToeNode.new(temp_board, @next_mover_mark, pos)

    end
    return children
  end
end
