# frozen_string_literal: true

require_relative '../lib/tree'

describe Tree do
  let(:tree) { Tree.new(array) }
  let(:array) { [1, 5, 3, 7, 8, 5] }
  let(:ordered_arr) { [1, 3, 5, 7, 8] }
  
  describe '#root' do
    it 'returns the root node of the tree' do
      expect(tree.root.data).to eq(5)
    end
  end

  describe '#array' do
    it 'returns a sorted and unique values array' do
      expected = [1, 3, 5, 7, 8]
      expect(tree.array).to eq(expected)
    end
  end

  describe '#build_tree' do
    it 'returns the root node of the tree' do
      expect(tree.build_tree(ordered_arr).data).to eq(5)
    end

    it 'builds a balanced binary search tree out of the array' do
      root_node = tree.build_tree(ordered_arr)
      expect(root_node.data).to eq(5)

      left_branch_root = root_node.left_node
      expect(left_branch_root.data).to eq(3)
      expect(left_branch_root.left_node.data).to eq(1)
      expect(left_branch_root.right_node).to eq(nil)

      right_branch_root = root_node.right_node
      expect(right_branch_root.data).to eq(8)
      expect(right_branch_root.left_node.data).to eq(7)
      expect(right_branch_root.right_node).to eq(nil)
    end
  end

  describe '#find' do
    it 'returns the node containing the specified value or nil' do
      expect(tree.find(8).data).to eq(8)
      expect(tree.find(100)).to eq(nil)
    end
  end

  describe '#insert' do
    xit 'inserts a node into the tree' do

    end
  end

  describe '#delete' do
  end

  describe '#level_order' do
  end

  describe '#inorder' do
  end
  
  describe '#preorder' do
  end
  
  describe '#postorder'do
  end

  describe '#height' do
  end

  describe '#depth' do
  end

  describe '#balanced?' do
  end

  describe '#rebalance' do
  end

  describe '#build_tree' do
  end

end
