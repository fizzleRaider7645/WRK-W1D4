require_relative "00_tree_node"

class KnightPathFinder
  
  def initialize(position)
    @grid = Array.new(8) { Array.new(8) }
    @start_position = position
    @move_tree = []
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
    potential_moves = pos.valid_moves.select {|row,col| row.between?(0,7) && col.between?(0,7)}
    potential_moves.reject! {|move| @visited_positions.incude?(move)}
    potential_moves.each {|move| @visited_positions << move}
  end
  
  def build_move_tree
    root_node = PolyTreeNode.new(@start_position)
    move_tree = []
    move_maker = [root_node]
    
    until move_maker.empty?
      move_node = move_maker.shift 
      move_tree << move_node 
      unless new_move_positions(move_node.value).empty?
        new_move_positions(move_node.value).each do |pos|
          move_maker << PolyTreeNode.new(pos)
        end
      end
    end
  end
  
  def find_path
    
  end
  
  
  
  
  
end