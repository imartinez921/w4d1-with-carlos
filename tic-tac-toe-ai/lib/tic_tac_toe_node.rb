require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = Board.new
    @next_mover_mark = :x
    if prev_move_pos == nil
      @prev_move_pos = nil
    else @prev_move_pos = prev_move_pos
    end
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_pos = []
    (0...@board.length).each do |i|
      (0...@board.length).each do |j|
        if @board.empty?([i,j])
          empty_pos << [i,j]
        end
      end
    end

    children = []
    empty_pos.each do |pos|
      temp_board = @board.dup

      temp_board.place_mark(pos, @next_mover_mark)

      @next_mover_mark == :x ? @next_mover_mark = :o : @next_mover_mark = :x

      children << TicTacToeNode.new(temp_board, @next_mover_mark, pos)

    end
    return children
  end
end
