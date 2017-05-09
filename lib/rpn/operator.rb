module RPN
  class Operator
    class TooFewOperandsError < StandardError
      def initialize(msg = nil)
        msg ||= 'Too few operands were given to one of your operators.' \
          ' Please, check the expression you have provided.'

        super(msg)
      end
    end

    class ZeroDivisionError < StandardError
      def initialize(msg = nil)
        msg ||= 'Divisions by zero are not allowed.'

        super(msg)
      end
    end

    attr_reader :name, :arity

    def initialize(name)
      @name = name
      @arity = 2
    end

    def apply_to(stack)
      operands = stack.pop(@arity)
      check_required_num_of_operands(operands)
      check_division_by_zero(operands.last)

      result = operands.first.send(name, operands.last)
      stack.push(result)
    end

    private

    def check_required_num_of_operands(operands)
      raise TooFewOperandsError if operands.length < @arity
    end

    def check_division_by_zero(divisor)
      return if name != '/'

      raise ZeroDivisionError if divisor.zero?
    end
  end
end
