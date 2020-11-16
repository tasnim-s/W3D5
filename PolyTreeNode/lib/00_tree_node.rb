require "byebug"

class PolyTreeNode

    attr_accessor :value, :parent, :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end
    
    def parent=(node)
        @parent.children.delete(self) unless self.parent.nil?
        @parent = node
        node.children << self unless node.nil?
    end

    def add_child(child_node)
        child_node.parent = self unless child_node.parent == self
    end

    def remove_child(child_node)
        raise "Not a child" if child_node.parent != self
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value

        self.children.each do |child|
            the_one = child.dfs(target_value)
            return the_one unless the_one.nil?
        end

        nil
    end

    def bfs(target_value)
        queue = [self]

        until queue.empty?
            first_node = queue.shift
            return first_node if first_node.value == target_value
            queue += first_node.children
        end

        nil
    end
end