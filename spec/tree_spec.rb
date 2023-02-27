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
      expect(tree.find(3).left_node.data).to eq(1)
      tree.delete(1)
      expect(tree.find(3).left_node).to eq(nil)
    end

    it 'replaces the deleted node with its successor if it only has one child' do
      expect(tree.root.right_node.data).to eq(8)
      tree.delete(8)
      expect(tree.root.right_node.data).to eq(7)
    end

    it 'replaces the deleted node with the next in-sequence node by value if deleted node has two children' do
      tree.insert(9)
      expect(tree.root.right_node.data).to eq(8)
      tree.delete(8)
      expect(tree.root.right_node.data).to eq(9)
      expect(tree.root.right_node.left_node.data).to eq(7)
    end
  end

  describe '#find_predecessor_node' do
    it 'returns the parent node' do
      parent_node = tree.find_predecessor_node(1)
      expect(parent_node.data).to eq(3)
    end

    it 'returns nil if the root node is selected' do
      expect(tree.find_predecessor_node(5)).to eq(nil)
    end
  end

  describe '#node_has_no_child?' do 
    it 'returns true if node has no child' do
      no_child_node = tree.find(1)
      expect(tree.node_has_no_child?(no_child_node)).to be(true)
    end

    it 'returns false if node has at least one child' do
      single_child_node = tree.find(3)
      double_child_node = tree.find(5)
      expect(tree.node_has_no_child?(single_child_node)).to be(false)
      expect(tree.node_has_no_child?(double_child_node)).to be(false)
    end
  end

  describe '#node_has_one_child?' do
    it 'returns true if node has one child' do
      single_child_node = tree.find(3)
      expect(tree.node_has_one_child?(single_child_node)).to be(true)
    end

    it 'returns false if node has none or two children' do
      double_child_node = tree.find(5)
      no_child_node = tree.find(1)
      expect(tree.node_has_one_child?(double_child_node)).to be(false)
      expect(tree.node_has_one_child?(no_child_node)).to be(false)
    end
  end

  describe '#node_has_two_children?' do
    it 'returns true if node has two children' do
      double_child_node = tree.find(5)
      expect(tree.node_has_two_children?(double_child_node)).to be(true)
    end

    it 'returns false if node has one or no children' do
      no_child_node = tree.find(1)
      single_child_node = tree.find(3)
      expect(tree.node_has_two_children?(no_child_node)).to be(false)
      expect(tree.node_has_two_children?(single_child_node)).to be(false)
    end
  end

  describe '#find_next_node_in_sequence' do
    it 'returns the next highest node' do
      node = tree.find(5)
      expect(tree.find_next_node_in_sequence(node.right_node).data).to eq(7)
    end
  end

  describe '#delete_no_children_node' do
    it 'deletes a node with no children' do
      node = tree.find(7)
      parent_node = tree.find(8)
      expect(node).to be_an_instance_of(Node)
      tree.delete_no_children_node(node, parent_node)
      expect(parent_node.left_node).to be(nil)
    end
  end

  describe '#delete_single_child_node' do
    it 'deletes a node with one child' do
      node = tree.find(8)
      parent_node = tree.find(5)
      expect(node).to be_an_instance_of(Node)
      tree.delete_single_child_node(node, parent_node)
      expect(parent_node.right_node.data).to be(7)
    end
  end 
  
  describe '#delete_double_child_node' do
    it 'deletes a node with two children' do
      node = tree.find(8)
      parent_node = tree.find(5)
      tree.insert(9)
      expect(node).to be_an_instance_of(Node)
      tree.delete_double_child_node(node, parent_node)
      expect(parent_node.right_node.data).to be(9)
    end
  end

  describe '#level_order' do
    context 'no block given' do
      it 'returns a balanced array' do
        expected = [5, 3, 8, 1, 7]
        expect(tree.level_order).to eq(expected)
      end
    end

    context 'a block is given' do
      it 'yields each node into the block' do
        nodes = [5, 3, 8, 1, 7]
        expect(tree.level_order).to eq(nodes)
        tree.level_order { |node| node.data += 1 }
        expected = [6, 4, 9, 2, 8]
        expect(tree.level_order).to eq(expected)
      end
    end
  end

  describe '#inorder' do
    context 'when a block is given' do
      it 'yields the node' do
        expected = [2, 4, 6, 8, 9]
        tree.inorder { |node| node.data += 1 }
        expect(tree.inorder).to eq(expected)
      end
    end

    context 'when a block is not given' do
      it 'returns an array' do
        expected = [1, 3, 5, 7, 8]
        expect(tree.inorder).to eq(expected)
      end
    end
  end
  
  describe '#preorder' do
    context 'when a block is given' do
      it 'yields the node' do
        expected = [6, 4, 2, 9, 8]
        tree.preorder { |node| node.data += 1 }
        expect(tree.preorder).to eq(expected)
      end
    end

    context 'when a block is not given' do
      it 'returns an array' do
        expected = [5, 3, 1, 8, 7]
        expect(tree.preorder).to eq(expected)
      end
    end
  end
  
  describe '#postorder'do
  context 'when a block is given' do
    it 'yields the node' do
      expected = [2, 4, 8, 9, 6]
      tree.postorder { |node| node.data += 1 }
      expect(tree.postorder).to eq(expected)
    end
  end

  context 'when a block is not given' do
    it 'returns an array' do
      expected = [1, 3, 7, 8, 5]
      expect(tree.postorder).to eq(expected)
    end
  end
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
