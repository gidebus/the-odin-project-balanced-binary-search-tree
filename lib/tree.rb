# frozen_string_literal: true

require_relative './node'

# Tree class that takes an array, and a root node
class Tree
  attr_accessor :array, :root

  def initialize(array = nil)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(arr)
    return if arr.empty?

    midpoint = (arr.length) / 2
    root = Node.new(arr[midpoint])
    root.left_node = build_tree(arr.take(midpoint))
    root.right_node = build_tree(arr.drop(midpoint + 1))
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
  
  def insert(value)
    return nil if value < 1
    return find(value) unless find(value).nil?
   
    new_node = Node.new(value)
    return @root = new_node if @root.nil?
    node = @root

    until node.nil?
      if value < node.data
        return node.left_node = new_node if node.left_node.nil?
        node = node.left_node
      elsif value > node.data
        return node.right_node = new_node if node.right_node.nil?
        node = node.right_node
      end
    end
  end

  def find(value)
    node = @root

    until node.nil?
      return nil if node.nil?
      return node if node.data == value
      node = node.left_node if value < node.data  
      node = node.right_node if value > node.data
    end
  end

end

arr = [1, 3, 5, 7, 8] 
t = Tree.new(arr)
t.pretty_print
t.insert(9)
puts ''
t.pretty_print
