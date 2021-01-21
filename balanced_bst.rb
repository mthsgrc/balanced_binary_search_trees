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

  def initialize(array = [])
    @array = sort_array(array)
    p @array
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
    if value == root.data
      return nil
    end

    if root.data < value
      root.right.nil? ? root.right = Node.new(value) : insert(value, root.right)
    else
      root.left.nil? ? root.left = Node.new(value) : insert(value, root.left)
    end
  end

  def min_value(node)
	current = node 

	while(current.left != nil) 
		current = current.left
	end	
	return current
  end

  def delete(value, root = @root)
    return root if root.nil?

    if value < root.data
      root.left = delete(value, root.left)
    elsif value > root.data
      root.right = delete(value, root.right)
    else
      if root.left.nil?
        temp = root.right
        root = nil
        return temp
      elsif root.right.nil?
      	temp = root.left
      	root = nil
      	return temp
      end
      temp = min_value(root.right)

      root.data = temp.data

      root.right = delete(temp.data, root.right)
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


  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

end


# array = [1, 7, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
array = [1, 3, 4, 7, 5, 6, 7]

bst = Tree.new(array)

bst.insert(10)
bst.insert(11)
bst.insert(31)

# binding.pry
puts

# puts bst.find(3)
# puts bst.find(10)

puts
bst.pretty_print

bst.delete(10)
bst.delete(31)
bst.delete(4)


bst.pretty_print
# bst.is_leaf?(7)


# bst.pretty_print
