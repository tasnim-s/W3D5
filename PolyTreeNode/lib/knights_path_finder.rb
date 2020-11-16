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
            new_move_positions(checking.value).each do |pos|
                child = PolyTreeNode.new(pos)
                checking.add_child(child)
            end
            queue += checking.children
        end
    end

    def new_move_positions(pos)
        remaining = KnightPathFinder.valid_moves(pos).reject {|move| @considered_positions.include?(move)}
        @considered_positions += remaining
        remaining
    end

    def find_path(end_pos)
        last_node = @root_node.dfs(end_pos)
        trace_path_back(last_node).reverse
    end

    def trace_path_back(node)
        return [node.value] if node.parent.nil?
        path_back = [node.value]
        path_back += trace_path_back(node.parent)
    end

end


kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]