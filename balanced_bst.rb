require 'pry'

class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    if other.is_a?(Node)
      self.data <=> other.data
    else
      self.data <=> other
    end
  end
end


class Tree
  attr_accessor :root, :array

  def initialize(array)
    @array = sort_array(array) if array.is_a?(Array)
    @root = build_tree(array)
  end

  def sort_array(array)
    array.sort!.uniq!
    array
  end

  def build_tree(array, start = 0, final = array.length - 1)
    return nil if array.empty?

    mid = (start + final) / 2
    root_node = Node.new(array[mid])
    root_node.left = build_tree(array[0...mid])
    root_node.right = build_tree(array[mid+1..-1])
    root_node
  end

  def insert(value, root = @root)
    #value already exists
    if value == root.data
      return nil
    end

    #if value is greater than root, insert to right
    if value > root.data
      root.right.nil? ? root.right = Node.new(value) : insert(value, root.right)
      #the value is less than root, insert left
    else
      root.left.nil? ? root.left = Node.new(value) : insert(value, root.left)
    end
  end

  #find min value in tree
  def min_value(node)
    current = node
    while(current.left != nil)
      current = current.left
    end
    return current.data
  end

  def delete(value, root = @root)
    #base case
    return root if root.nil?

    # Value is in left or right subtree comparing with root values
    if value < root.data
      root.left = delete(value, root.left)
    elsif value > root.data
      root.right = delete(value, root.right)
      # Value is at root's key. This node is to be deleted
    else
      # Node with only one child or no child
      if root.left.nil?
        temp = root.right
        root = nil
        return temp
      elsif root.right.nil?
        temp = root.left
        root = nil
        return temp
      end
      # Node with two children
      # Get the min value in subtree
      temp = min_value(root.right)
      # Copy the successor content to this node
      root.data = temp
      # Delete inoder successor
      root.right = delete(root.data, root.right)
    end
    return root
  end

  def find(value, root = @root)
    return nil if root.nil?

    if root.data == value
      return root
    end
    if value < root.data
      return find(value, root.left)
    else
      return find(value, root.right)
    end
  end

  def level_order(root = @root, queue = [], output = [])
    return nil if root.nil?
    # queue << root
    # while !queue.empty?
    #   current = queue.shift
    #   binding.pry
    #   queue << current.left if current.left != nil
    #   queue << current.right if current.right != nil

    #   output << current.data
    # end
    # output

    # below do the same recursively
    output << root.data
    queue << root.left unless root.left.nil?
    queue << root.right unless root.right.nil?
    return if queue.empty?
    level_order(queue.shift, queue, output)
    output
  end

  def inorder(root = @root, inorder_list = [])
    return if root.nil?
    inorder(root.left, inorder_list)
    inorder_list << root.data
    inorder(root.right, inorder_list)
    inorder_list
  end

  def preorder(root = @root, preorder_list = [])
    return if root.nil?
    preorder_list << root.data
    preorder(root.left, preorder_list)
    preorder(root.right, preorder_list)
    preorder_list
  end

  def postorder(root = @root, postorder_list = [])
    return if root.nil?
    postorder(root.left, postorder_list)
    postorder(root.right, postorder_list)
    postorder_list << root.data
    postorder_list
  end

  def height(node = root)
    unless node.nil?
      node = find(node)
    end
    return -1 if node.nil?

    l_height = height(node.left)
    r_height = height(node.right)
    l_height > r_height ? l_height + 1 : r_height + 1
  end

  def depth(node, parent = root, depth = 0)
    return -1 if parent.nil?

    if node < parent.data
      depth += 1
      depth(node, parent.left, depth)
    elsif node > parent.data
      depth += 1
      depth(node, parent.right, depth)
    else # they are the same
      depth
    end
  end

  def balanced?(node = root)
    return true if node.nil?
    l_height = height(node.left)
    r_height = height(node.right)
    result = l_height.abs - r_height.abs
    result = result.abs
    if result > 1
      return false
    else
      true
    end
  end

  def rebalance
    return if self.balanced? == true

    to_rebalance = self.level_order
    to_rebalance = sort_array(to_rebalance)
    balanced_tree = Tree.new(to_rebalance)
    balanced_tree
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

array = Array.new(15) { rand(1..1000) }

bst = Tree.new(array)

p "Is the tree balanced? #{bst.balanced?}"
puts
p "Inorder transversal > #{bst.inorder}"
p "Preorder transversal > #{bst.preorder}"
p "Postorder transversal > #{bst.postorder}"
puts
bst.pretty_print
puts
bst.insert(1200)
bst.insert(1010)
bst.insert(1230)
p "Is the tree balanced? #{bst.balanced?}"
puts
p 'Rebalancing the tree...'
puts
bst = bst.rebalance
p "Is the tree balanced? #{bst.balanced?}"
puts
p "Inorder transversal > #{bst.inorder}"
p "Preorder transversal > #{bst.preorder}"
p "Postorder transversal > #{bst.postorder}"
puts
bst.pretty_print