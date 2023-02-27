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

  def find_predecessor_node(value, node = @root)
    return nil if @root == value
    
    until node.nil? do
      return node if node.left_node.data == value || node.right_node.data == value
      value < node.data ? node = node.left_node : node = node.right_node
    end
  end

  def delete(value)
    return nil if value < 1
    return nil if find(value).nil?

    parent_node = find_predecessor_node(value)
    node = find(value)
    
    delete_no_children_node(node, parent_node) if node_has_no_child?(node)
    delete_single_child_node(node, parent_node) if node_has_one_child?(node)
    delete_double_child_node(node, parent_node) if node_has_two_children?(node)
  end

  def delete_no_children_node(node, parent_node)
    node.data > parent_node.data ? parent_node.right_node = nil : parent_node.left_node = nil
  end

  def delete_single_child_node(node, parent_node)
    child = node.left_node.nil? ? node.right_node : node.left_node
    node.data < parent_node.data ? parent_node.left_node = child : parent_node.right_node = child
  end

  def delete_double_child_node(node, parent_node) # 3 & 5
    replacement_node = find_next_node_in_sequence(node.right_node)
    replacement_node_parent = find_predecessor_node(replacement_node.data)
    delete_single_child_node(replacement_node, replacement_node_parent) if replacement_node.right_node.nil?
    replacement_node.left_node = node.left_node
    replacement_node.right_node = node.right_node
    node.data < parent_node.data ? parent_node.left_node = replacement_node : parent_node.right_node = replacement_node
  end

  def node_has_no_child?(node)
    node.left_node.nil? && node.right_node.nil?
  end

  def node_has_one_child?(node)
    !node_has_no_child?(node) && !node_has_two_children?(node)
  end

  def node_has_two_children?(node)
    !node.left_node.nil? && !node.right_node.nil?
  end

  def find_next_node_in_sequence(node = @root)
    return node if node.left_node.nil?
    find_next_node_in_sequence(node.left_node)
  end
end

# TODO Delete after:
# arr = [1, 3, 5, 7, 8] 
# arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ] 
# t = Tree.new(arr)
# t.insert(9)
# t.pretty_print
# puts ''
# t.delete(8)
# puts ''
# t.pretty_print
# puts ''