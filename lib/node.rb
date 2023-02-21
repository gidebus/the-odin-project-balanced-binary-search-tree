# frozen_string_literal: true

# Node class including a data, left, and right nodes.
class Node
  attr_accessor :data, :left_node, :right_node

  def initialize(
    data = nil, 
    left_node = nil,
    right_node = nil
  )
    @data = data
    @left_node = left_node
    @right_node = right_node
  end
end
