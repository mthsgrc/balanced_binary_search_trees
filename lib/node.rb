# Node cretor

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