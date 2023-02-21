# frozen_string_literal: true

require_relative '../lib/node'

describe Node do
let(:node) { Node.new('root node', left_node, right_node) }
let(:left_node) { Node.new('left node') }
let(:right_node) { Node.new('right node') }

  describe '#value' do
    it 'returns the value of the node' do
      expect(node.value).to eq('root node')
    end
  end

  describe '#left_node' do
    it 'returns the left node' do
      expect(node.left_node).to eq(left_node)
    end
  end


  describe '#right_node' do
    it 'returns the right node' do
      expect(node.right_node).to eq(right_node)
    end
  end
end