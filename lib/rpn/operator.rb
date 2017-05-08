module RPN
  class Operator
    attr_reader :name, :arity

    def initialize(name)
      @name = name
      @arity = 2
    end

    def apply_to(stack)
      operands = stack.pop(@arity)
      raise RPN::TooFewOperands if operands.length < @arity

      result = operands.first.send(name, operands.last)
      stack.push(result)
    end
  end
end
