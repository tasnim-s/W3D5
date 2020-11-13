require "byebug"

class PolyTreeNode

    attr_accessor :value, :parent, :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end
    
    def parent=(node)
        unless node == nil
            @parent.children.delete(self) unless self.parent == nil
            @parent = node
            node.children << self
        else
            @parent = nil
        end
    end

    def add_child(child_node)
        child_node.parent = self unless child_node.parent == self
    end

    def remove_child(child_node)
        raise "Not a child" if child_node.parent != self
        child_node.parent = nil
    end

    def dfs(target_value) # for binary tho
        return self if self.value == target_value
        return nil if self.children.empty?

        left = self.children.first
        right = self.children.last

        left.dfs(target_value) || right.dfs(target_value)
    end

    def bfs(target_value)
        queue = []
        queue << self

        until queue.empty?
            # debugger
            first_node = queue.shift
            return first_node if first_node.value == target_value
            first_node.children.each do |child|
                queue << child
            end
        end

        nil
    end
end