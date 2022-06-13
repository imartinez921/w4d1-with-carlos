require "byebug"
require_relative "00_tree_node.rb"


class KnightPathFinder
  attr_reader :considered_positions, :root_node

  def initialize(origin_pos)
    @start_pos = origin_pos
    @root_node = PolyTreeNode.new(origin_pos)
    @considered_positions = [origin_pos]

    build_move_tree
  end

  def build_move_tree
    queue = [@root_node]

    until queue.empty?

      new_positions = new_move_positions(queue.first.value)

      new_positions.each do |position|
        queue.first.add_child(PolyTreeNode.new(position))
      end

      first_node = queue.shift

      queue.concat(first_node.children)
    end

  end

  def self.valid_moves(pos) #arg is starting position [y,x], returns an array of valid moves
    movement = [[2,1], [1,2], [-1,2], [-2,1], [-2,-1], [-1,-2], [1,-2], [2,-1]]
    moves = []
    
    movement.each do |move|
        is_move = [(pos[0] + move[0]), pos[1] + move[1]]
        if (is_move[0] >= 0 && is_move[0] <= 7) && (is_move[1] >= 0 && is_move[1] <= 7)
          moves << is_move
        end
    end
    return moves
  end

  def new_move_positions(pos)
    new_moves = []

    valid_moves = KnightPathFinder.valid_moves(pos)
    valid_moves.each do |move|
      if !@considered_positions.include?(move)
        @considered_positions << move
        new_moves << move
      end
    end
    return new_moves
  end


  def find_path(end_pos)
    end_node = self.root_node.bfs(end_pos)

    trace_path_back(end_node) #returns path array
  end

  def trace_path_back(end_node)
    queue = [end_node] #queue of Node instances
    path = [end_node.value] #path of positions
    
    until queue.first.parent.nil?
      first_node = queue.shift
      queue << first_node.parent
      path.unshift(first_node.value)
    end

    return path.unshift(root_node.value)
  end


end

