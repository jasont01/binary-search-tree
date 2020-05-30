class Node
  include Comparable
  attr_reader :value
  attr_accessor :left, :right
    
    def initialize(value = nil)
      @value = value
      @left = nil
      @right = nil
    end
  
    def <=>(other)
      self.value <=> other.value
    end
  end