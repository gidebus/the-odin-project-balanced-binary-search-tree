# frozen_string_literal: true

require_relative '../lib/tree'
require_relative '../lib/node'

describe Tree do
  let(:tree) { Tree.new(array) }
  let(:array) { [1, 5, 3, 7, 8, 5] }
  
  describe '#root' do
    it 'returns the root node of the tree' do
      expect(tree.root).to eq()
    end
  end

  describe '#array' do
    it 'returns original an array' do
      expect(tree.array).to eq(array)
    end
  end

  describe '#build_tree' do
    it 'returns the root node of the tree' do
      expect(tree.build_tree).to eq()
    end

    it 'builds a balanced binary search tree out of the array' do
      expect().to eq()
    end
  end

end
