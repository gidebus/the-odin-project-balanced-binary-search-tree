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
    it 'inserts a node into the tree' do
      expect(tree.find(9)).to be(nil)
      tree.insert(9)
      expect(tree.find(9).data).to eq(9)
    end

    it 'inserts a lower node into the left branch' do
      left_root_node = tree.find(3)
      expect(left_root_node.right_node).to eq(nil)
      tree.insert(4)
      expect(left_root_node.right_node.data).to eq(4)
    end

    it 'inserts a higher node into the right branch' do
      right_root_node = tree.find(8)
      expect(right_root_node.right_node).to eq(nil)
      tree.insert(9)
      expect(right_root_node.right_node.data).to eq(9)
    end

    it 'returns nil if insert value is lower than 0' do
      expect(tree.insert(-1)).to eq(nil)
      expect(tree.insert(0)).to eq(nil)
    end

    it 'does not duplicate a node that already exists' do
      right_root_node = tree.find(8)
      tree.insert(8)
      expect(right_root_node.left_node).not_to eq(8)
      expect(right_root_node.right_node).not_to eq(8)
      expect(right_root_node.left_node.right_node).not_to eq(8)
    end
  end

  describe '#delete' do
    it 'deletes a value with no children' do
      expect(tree.find(1).data).to eq(1)
      tree.delete(1)
      expect(tree.find(1)).to eq(nil)
    end

    it 'replaces the deleted node with its successor if it only has one child' do
      expect(tree.right_node.data).to eq(8)
      tree.delete(8)
      expect(tree.right_node.data).to eq(7)
    end

    it 'replaces the deleted node with the next in-sequence node by value if deleted node has two children' do
      tree.insert(9)
      expect(tree.right_node.data).to eq(8)
      tree.delete(8)
      expect(tree.right_node.data).to eq(7)
      expect(tree.right_node.right_node.data).to eq(9)
    end
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
end
