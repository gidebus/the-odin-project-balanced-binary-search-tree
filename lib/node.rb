# frozen_string_literal: true

# Node class including a value, left, and right nodes.
class Node
  def initialize(
    value = nil, 
    left_node = nil,
    right_node = nil
  )
    @value = value
    @left_node = left_node
    @right_node = right_node
  end
end
