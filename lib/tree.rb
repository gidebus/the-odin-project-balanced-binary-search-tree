# frozen_string_literal: true

require_relative './node'

# Tree class that takes an array, and a root node
class Tree
  attr_accessor :array, :root

  def initialize(array = nil)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(arr_of_nodes)
    return Node.new(arr_of_nodes.first) if arr_of_nodes.length <= 1

    midpoint = (arr_of_nodes.length / 2).round
    root = Node.new(arr_of_nodes[midpoint])
    left = build_tree(arr_of_nodes[0...midpoint])
    right = build_tree(arr_of_nodes[(midpoint + 1)..arr_of_nodes.length - 1])       

    root.left_node = left
    root.right_node = right

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
  
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324] # => [1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345]
tree = Tree.new(arr)
tree.pretty_print
p tree.array