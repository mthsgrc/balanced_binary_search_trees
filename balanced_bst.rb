require 'pry'

class Node
  attr_accessor :data, :left, :right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end


class Tree
  attr_accessor :root, :array

  def initialize(array)
    @array = sort_array(array)
    # p @array
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
    # binding.pry
    #value already exists
    if value == root.data
      return nil
    end

    #if value is greater than root, insert to right
    if root.data < value
      root.right.nil? ? root.right = Node.new(value) : insert(value, root.right)
      #otherwise, that is, the value is less than root, insert left
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
    return "Value #{value} doesn't exist in tree." if root.nil?

    if root.data == value
      return "#{root.data} found in tree."
    end

    if value < root.data
      return find(value, root.left)
    else
      return find(value, root.right)
    end
  end

  def level_order(root = @root, queue = [], output = [])
    return nil if root.nil?

    queue << root

    while !queue.empty?
      current = queue.shift

      # binding.pry
      queue << current.left if current.left != nil
      queue << current.right if current.right != nil

      output << current.data
    end
    output

    # below is the same recursively
    # output << root.data
    # queue << root.left unless root.left.nil?
    # queue << root.right unless root.right.nil?
    # p output
    # return if queue.empty?
    # level_order(queue.shift, queue, output)
    # output
  end


  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

end

# │                   ┌── 31
# │               ┌── 11
# │           ┌── 10
# │       ┌── 7
# │   ┌── 6
# │   │   └── 5
# └── 4
#     │   ┌── 3
#     └── 1


# array = [1, 7, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
array = [1, 3, 4, 7, 5, 6, 7]

bst = Tree.new(array)

bst.insert(10)
bst.insert(11)
bst.insert(31)


bst.pretty_print
bst.level_order

# bst.pretty_print
