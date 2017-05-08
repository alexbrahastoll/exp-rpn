module RPN
  class Stack
    def initialize(store = [])
      @store = store
    end

    def push(*elements)
      @store.concat(elements)
      self
    end

    def pop(n = 1)
      n > 1 ? @store.pop(n) : @store.pop
    end

    def last
      @store.last
    end

    def empty?
      @store.empty?
    end

    def reset
      @store = []
    end
  end
end
