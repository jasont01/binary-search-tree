#Binary Search Tree Project
#Created by Jason Thompson | jason@jasont.us | github.com/jasont01
#for The Odin Project (theodinproject.com)

require './node.rb'

class Tree
  attr_accessor :root
  
  def initialize(array)
    @root = nil
    build_tree(array)
  end

  def build_tree(array)
    array.uniq!
    @root = Node.new(array.shift)
    array.each { |value| insert(value) }
    rebalance! if !balanced?
  end

  def insert(value)
    sort_node(@root, Node.new(value)) if find(value).nil?
  end

  def sort_node(parent_node, new_node)
    if new_node.value < parent_node.value
      #go left
      parent_node.left.nil? ? parent_node.left = new_node : sort_node(parent_node.left, new_node)
    else
      #go right
      parent_node.right.nil? ? parent_node.right = new_node : sort_node(parent_node.right, new_node)
    end
  end

  def delete(value, node = @root)
    return nil if node.nil?
    if value < node.value
      node.left = delete(value, node.left)
    elsif value > node.value
      node.right = delete(value, node.right)
    #From here value == node.value
    #Case 1: No children
    elsif node.left.nil? && node.right.nil?
      node = nil
    #Case 2: One child
    elsif node.left.nil?
      node = node.right
    elsif node.right.nil?
      node = node.left
    #Case 3: Two children
      right_min = find_tree_min(node.right)
      node.value = right_min.value
      node.right = delete(right_min.value, node.right)
    end
    node
  end

  def find(value, node = @root)
    #accepts a value and returns the node with the given value
    return nil if node.nil?   #return nil if value does not exist in tree
    return node if node.value == value
    value < node.value ? find(value, node.left) : find(value, node.right)
  end

  def level_order(node = @root)
    return if node.nil?
    queue = []
    results = []
    queue.unshift(node)
    until queue.empty?
      current = queue.pop
      block_given? ? yield(current) : results << current.value
      queue.unshift(current.left) unless current.left.nil?
      queue.unshift(current.right) unless current.right.nil?
    end
    return results unless results.empty?
  end

  # Dynamically declaring :preorder :inorder :postorder
  %w[pre in post].each do |prefix|
    define_method("#{prefix}order") do |results = [], node = @root, &block|
      return if node.nil?

      !block.nil? ? block.call(node) : results << node.value if __method__ == :preorder
      __send__(__method__, results, node.left, &block) unless node.left.nil?
      !block.nil? ? block.call(node) : results << node.value if __method__ == :inorder
      __send__(__method__, results, node.right, &block) unless node.right.nil?
      !block.nil? ? block.call(node) : results << node.value if __method__ == :postorder
      return results unless results.empty?
    end
  end

  def depth(node = @root)
    return 0 if node.nil?
    [depth(node.left), depth(node.right)].max + 1
  end

  def balanced?(node = @root)
    return true if node.nil?
    left_height = depth(node.left)
    right_height = depth(node.right)
    return true if (left_height - right_height).abs <= 1
    false
  end

  def rebalance!
    sorted_arr = []
    bst_to_sorted_array(@root, sorted_arr)
    @root = sorted_array_to_balanced_bst(sorted_arr, 0, sorted_arr.length - 1)
  end

  private

  def find_tree_min(node)
    array = []
    bst_to_sorted_array(node, array)
    array.min
  end

  def bst_to_sorted_array(node, array)
    return if node.nil?

    bst_to_sorted_array(node.left, array)
    array << node
    bst_to_sorted_array(node.right, array)
  end

  def sorted_array_to_balanced_bst(array, start_index, end_index)
    return nil if start_index > end_index
    mid_index = (start_index + end_index) / 2
    node = array[mid_index]
    node.left = sorted_array_to_balanced_bst(array, start_index, mid_index - 1)
    node.right = sorted_array_to_balanced_bst(array, mid_index + 1, end_index)
    node
  end
end