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
      n > 1 ? @store.pop(n) : @store.pop
    end
  end
end
