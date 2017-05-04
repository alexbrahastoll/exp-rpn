module RPN
  class Stack
    def initialize
      @store = []
    end

    def push(*elements)
      @store.concat(elements)
      self
    end

    def pop(n = 1)
      @store.pop(n)
    end
  end
end
