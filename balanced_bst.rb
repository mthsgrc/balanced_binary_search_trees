require 'pry'

class Node
  attr_accessor :data, :l_children, :r_children

  def initialize(data)
    @data = data
    @l_children = nil
    @r_children = nil
  end
end



class Tree
  attr_accessor :root, :array

  def initialize(array)
    array.sort!.uniq!
    @array = array
    p @array
    @root = build_tree(@array)
  end

  def build_tree(array, start = 0, final = array.length - 1)
    return nil if start > final

    mid = (start + final) / 2
    # binding.pry

    @root = Node.new(array[mid])
    # p @root.data

    @root.l_children = build_tree(array[0...mid])
    @root.r_children = build_tree(array[mid+1..-1])

    @root
  end


  def insert(value)

  end


  def delete(value)

  end


  def find(value)

  end

  private

end


array = [1, 7, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
array2 = [1, 2, 3, 4, 7, 5, 6, 7]

bst = Tree.new(array2)
# bst2 = Tree.new(array)

puts bst.root.data
