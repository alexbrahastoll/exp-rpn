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

        expect(output).to eq('2')
      end

      xit 'does correctly interpret an expr. (two values and an operand)' do
      end

      xit 'does correctly interpret an expr. (multiple values and operands)' do
      end
    end

    context 'when the expression is invalid' do
      it 'does raise an error when the expr. has forbidden chars' do
        expr = 'an invalid expression!'
        interpreter = RPN::Interpreter.new

        expect do
          output = interpreter.interpret(expr)
        end.to raise_error(RPN::Interpreter::SyntaxError)
      end

      xit 'does raise an error when the expr. has too few values' do
      end

      xit 'does raise an error when the expr. has too many values' do
      end
    end
  end
end
