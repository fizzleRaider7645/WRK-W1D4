require_relative "00_tree_node"
require "byebug"

class KnightPathFinder
  
  attr_reader :visited_positions
  
  def initialize(position)
    @grid = Array.new(8) { Array.new(8) }
    @start_position = position
    @move_tree = PolyTreeNode.new(position)
    @visited_positions = [position]
  end
  
  def self.valid_moves(pos)
    answer = []
    answer << [pos[0] + 2, pos[1] + 1]
    answer << [pos[0] + 2, pos[1] - 1]
    answer << [pos[0] - 2, pos[1] - 1]
    answer << [pos[0] - 2, pos[1] + 1]
    answer << [pos[0] - 1, pos[1] + 2]
    answer << [pos[0] - 1, pos[1] - 2]
    answer << [pos[0] + 1, pos[1] + 2]
    answer << [pos[0] + 1, pos[1] - 2]
    answer
  end
  
  def new_move_positions(pos)
    potential_moves = KnightPathFinder.valid_moves(pos).select { |row,col| row.between?(0,7) && col.between?(0,7) }
    potential_moves.reject! { |move| @visited_positions.include?(move) }
    potential_moves.each { |move| @visited_positions << move }
    potential_moves
  end
  
  def build_move_tree
    
    @move_tree
    queue = [@move_tree]
    until queue.empty?
      move_node = queue.shift  
      val = new_move_positions(move_node.value)
      until val.empty?
        child = PolyTreeNode.new(val.shift)
        move_node.add_child(child)
      end
      move_node.children.each { |child| queue.push(child) }
    end
    @move_tree
  end
  
  def find_path(end_pos)
    terminal_node = @move_tree.bfs(end_pos)
    current_node = terminal_node
    traceback = []
    until current_node.parent == nil 
      traceback << current_node.value
      current_node = current_node.parent
    end 
    traceback.push(@start_position).reverse
  end
  
  def trace_path_back(node)
    
  end 
  
  
  
  
  
end