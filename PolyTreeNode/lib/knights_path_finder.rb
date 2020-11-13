require_relative "00_tree_node.rb"

class KnightPathFinder

    def self.valid_moves(pos)
        board = Array.new(8) {Array.new(8)}
        combos = []
        avail_long = [-3, 3]
        avail_short = [-1, 1]
        combos += (avail_long.product(avail_short) + avail_short.product(avail_long))
        combos.map do |combo|
            [pos[0] + combo[0] , pos[1] + combo[1]]
        end
    end

    def initialize(start_pos)
        @start_pos = start_pos
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        self.build_move_tree
    end

    def build_move_tree
        self.root_node.bfs()
    end

    def new_move_positions(pos)
        remaining = KnightPathFinder.valid_moves(pos).reject {|move| @considered_positions.include?(move)}
        @considered_positions += considered_positions
    end


end