module RPN
  class Interpreter
    class SyntaxError < StandardError; end

    attr_reader :last_expr

    def interpret(expr)
      self.last_expr = remove_extra_whitespace(expr)
      apply_values_and_operands
    end

    private

    def last_expr=(value)
      @last_expr = value
    end

    def remove_extra_whitespace(expr)
      expr.gsub(/\s+/, ' ')
    end

    def apply_values_and_operands
      values_and_operands.each do |value_or_operand|
        case value_or_operand
        when /\d+(\.\d+)?/
          # TODO Apply value to the stack.
        when /[\+\-\*\/]/
          # TODO Apply operand to the stack.
        else
          raise SyntaxError
        end
      end

      last_expr
    end

    def values_and_operands
      last_expr.split(' ')
    end
  end
end
