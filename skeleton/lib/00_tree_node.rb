require 'byebug'

class PolyTreeNode
  
  def initialize(value, par= nil)
    @parent = nil  
    @children = []
    @value = value 
    if par  
      self.parent = par 
    end 
  end
  
  def parent 
    @parent 
  end 
  
  def children
    @children
  end 
  
  def value
    @value
  end 
  
  def parent=(par)
    if parent 
      parent.children.delete(self) 
    end 
    @parent = par 
    if par 
      par.children << self unless par.children.include?(self)
    end 
  end
  
  def add_child(node)
    node.parent = self
  end
  
  def remove_child(node)
    if self.children.include?(node)
      node.parent = nil
    else
      raise "Not a child"
    end
  end
  
  def dfs(value)
    if value == self.value
      return self
    else
      @children.each do |child| 
        target = child.dfs(value)
        return target if target
      end
    end
    nil
  end
  
  def bfs(value)
    check = [self]
    
    until check.empty?
      node_checked = check.shift
      if value == node_checked.value
        return node_checked
      else 
        check += node_checked.children
      end
    end
    nil
  end 
end