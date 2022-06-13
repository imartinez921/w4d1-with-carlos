class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(p_node)
    if self.parent != p_node && self.parent != nil
      self.parent.children.delete(self)
    end
    @parent = p_node
    if self.parent != nil && !p_node.children.include?(self)
      p_node.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Not my child!" if !self.children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return nil if self.nil?
    return self if self.value == target

    self.children.each do |child| 
      result = child.dfs(target)
      return result unless result.nil?
    end
    nil
  end 

  def bfs(target)
    queue = [self]

    until queue.empty?
      first_node = queue.shift
      return first_node if first_node.value == target
      queue.concat(first_node.children)
    end

    nil
  end

end