require_relative "00_tree_node.rb"

class KnightPathFinder

    def self.valid_moves(pos)
        combos = []
        avail_long = [-2, 2]
        avail_short = [-1, 1]

        combos += (avail_long.product(avail_short) + avail_short.product(avail_long))

        combos.map! do |combo|
            [pos[0] + combo[0] , pos[1] + combo[1]]
        end

        combos.reject {|combo| combo[0] < 0 || combo[0] > 7 || combo[1] < 0 || combo[1] > 7}
    end

    def initialize(start_pos)
        @start_pos = start_pos
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        build_move_tree
    end

    def build_move_tree
        queue = [@root_node]

        until queue.empty?
            checking = queue.shift
            new_move_positions(@root_node.value)
        end

        []
    end

    def new_move_positions(pos)
        remaining = KnightPathFinder.valid_moves(pos).reject {|move| @considered_positions.include?(move)}
        @considered_positions += remaining
    end


end


p kpf = KnightPathFinder.new([0, 0])
p kpf.new_move_positions([2,1])