require 'spec_helper'

RSpec.describe RPN::Operator do
  describe '#apply_to' do
    context 'when there are at least two operands in the stack' do
      it 'does push the result of the operation to the stack' do
        seven = RPN::Value.new('7')
        four = RPN::Value.new('4')
        stack = RPN::Stack.new([seven, four])
        operator = RPN::Operator.new('-')
        expected_result = RPN::Value.new('3')

        operator.apply_to(stack)

        expect(stack.pop).to eq(expected_result)
      end
    end

    context 'when there are less than two operands in the stack' do
      it 'does raise an error' do
        stack = RPN::Stack.new([RPN::Value.new('1')])
        operator = RPN::Operator.new('+')

        expect do
          operator.apply_to(stack)
        end.to raise_error(RPN::Operator::TooFewOperandsError)
      end
    end

    context 'when a division by zero is attempted' do
      it 'does raise an error' do
        stack = RPN::Stack.new([RPN::Value.new('2.0'), RPN::Value.new('0.0')])
        operator = RPN::Operator.new('/')

        expect do
          operator.apply_to(stack)
        end.to raise_error(RPN::Operator::ZeroDivisionError)
      end
    end
  end
end
