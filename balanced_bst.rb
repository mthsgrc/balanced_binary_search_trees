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
    p @array
    @root = build_tree(@array)
  end

  def sort_array(array)
    array.sort!.uniq!
    array
  end


  def build_tree(array, start = 0, final = array.length - 1)
    return nil if start > final

    mid = (start + final) / 2
    root_node = Node.new(array[mid])

    root_node.left = build_tree(array[0...mid])
    root_node.right = build_tree(array[mid+1..-1])
    root_node
  end


  def insert(value, root)
  	return Node.new(value) if root.nil?

  	if root.data == value
  		return root
  	elsif root.data < value
		root.right = insert(value, root.right)  			
	else	
		root.left = insert(value, root.left)  			
  	end
  end


  def delete(value, root)

  end


  def find(value, root)
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
array = [1, 2, 3, 4, 7, 5, 6, 7]

bst = Tree.new(array)
puts
# puts bst.find(4, bst.root)
# puts bst.find(1, bst.root)
# puts bst.find(10, bst.root)
# puts bst.find(6, bst.root)

bst.pretty_print

bst.insert(10, bst.root)
puts "-------"

bst.pretty_print
