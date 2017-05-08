require 'rpn/version'
require 'rpn/interpreter'
require 'rpn/stack'
require 'rpn/operator'
require 'rpn/value'

module RPN
  BINARY_OPERATORS = ['+', '-', '*', '/'].freeze

  class TooFewOperands < StandardError
    def initialize(msg = nil)
      msg ||= 'Too few operands were given to one of your operators.' \
        ' Please, check the expression you have provided. The stack was reset.'

      super(msg)
    end
  end

  class TooManyOperands < StandardError
    def initialize(msg = nil)
      msg ||= 'Too many operands were given to one of your operators.' \
        ' Please, check the expression you have provided. The stack was reset.'

      super(msg)
    end
  end
end
