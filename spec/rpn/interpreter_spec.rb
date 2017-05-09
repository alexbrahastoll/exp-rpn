require 'spec_helper'

RSpec.describe RPN::Interpreter do
  describe '#interpret' do
    it 'does remove extra whitespace characters from expr' do
      expr = '2   3  +'
      expected_cleaned_up_expr = '2 3 +'
      interpreter = RPN::Interpreter.new

      interpreter.interpret(expr)

      expect(interpreter.last_expr).to eq(expected_cleaned_up_expr)
    end

    context 'when the expression is valid' do
      it 'does correctly interpret an expr. (single value)' do
        expr = '2'
        interpreter = RPN::Interpreter.new

        output = interpreter.interpret(expr)

        expect(output).to eq('2.0')
      end

      it 'does correctly interpret an expr. (two values and an operator)' do
        expr = '3 2 -'
        interpreter = RPN::Interpreter.new

        output = interpreter.interpret(expr)

        expect(output).to eq('1.0')
      end

      it 'does correctly interpret an expr. (multiple values and operators)' do
        expr = '3 2 4 + * 2 /' # 3 * (2 + 4) / 2
        interpreter = RPN::Interpreter.new

        output = interpreter.interpret(expr)

        expect(output).to eq('9.0')
      end

      it 'does correctly interpret an expr. split into multiple parts' do
        expr_part1 = '5'
        expr_part2 = '3'
        expr_part3 = '-'
        interpreter = RPN::Interpreter.new

        interpreter.interpret(expr_part1)
        interpreter.interpret(expr_part2)
        final_output = interpreter.interpret(expr_part3)

        expect(final_output).to eq('2.0')
      end
    end

    context 'when the expression is invalid' do
      it 'does raise an error when the expr. has forbidden chars' do
        expr = 'an invalid expression!'
        interpreter = RPN::Interpreter.new

        expect do
          interpreter.interpret(expr)
        end.to raise_error(RPN::Interpreter::SyntaxError)
      end

      it 'does reset the stack when the expr. has forbidden chars' do
        expr = 'an invalid expression!'
        stack = RPN::Stack.new([RPN::Value.new('1.0')])
        interpreter = RPN::Interpreter.new(stack)

        interpreter.interpret(expr) rescue nil

        expect(stack.empty?).to be_truthy
      end

      it 'does raise an error when the expr. has too few values' do
        expr = '3 +'
        interpreter = RPN::Interpreter.new

        expect do
          interpreter.interpret(expr)
        end.to raise_error(RPN::Operator::TooFewOperandsError)
      end

      it 'does reset the stack when the expr. has too few values' do
        expr = '3 +'
        stack = RPN::Stack.new
        interpreter = RPN::Interpreter.new(stack)

        interpreter.interpret(expr) rescue nil

        expect(stack.empty?).to be_truthy
      end

      it 'does raise an error when the expr. has a division by zero' do
        expr = '10 0 /'
        interpreter = RPN::Interpreter.new

        expect do
          interpreter.interpret(expr)
        end.to raise_error(RPN::Operator::ZeroDivisionError)
      end

      it 'does reset the stack when the expr. has a division by zero' do
        expr = '10 0 /'
        stack = RPN::Stack.new([RPN::Value.new('1.0')])
        interpreter = RPN::Interpreter.new(stack)

        interpreter.interpret(expr) rescue nil

        expect(stack.empty?).to be_truthy
      end
    end
  end
end
