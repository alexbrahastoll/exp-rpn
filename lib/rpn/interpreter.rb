module RPN
  class Interpreter
    class SyntaxError < StandardError; end

    attr_reader :last_expr

    def initialize(stack = RPN::Stack.new)
      @stack = stack
    end

    def interpret(expr)
      self.last_expr = remove_extra_whitespace(expr)
      apply_values_and_operators
    end

    private

    def stack
      @stack
    end

    def last_expr=(value)
      @last_expr = value
    end

    def remove_extra_whitespace(expr)
      expr.gsub(/\s+/, ' ')
    end

    def apply_values_and_operators
      values_and_operators.each do |value_or_operator|
        case value_or_operator
        when /\d+(\.\d+)?/
          value = RPN::Value.new(value_or_operator)
          value.apply_to(stack)
        when /[\+\-\*\/]/
          # TODO Apply operator to the stack.
        else
          raise SyntaxError
        end
      end

      stack.pop.to_s
    end

    def values_and_operators
      last_expr.split(' ')
    end
  end
end
