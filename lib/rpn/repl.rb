module RPN
  class REPL
    # Some commands that we should interpret as quit commands are being
    # received as a "nil input" (e.g. CTRL + D in my macOS 10.12.4).
    QUIT_COMMANDS = ['q', nil].freeze

    def initialize(interpreter = RPN::Interpreter.new)
      @interpreter = interpreter
      handle_relevant_signals
    end

    def start
      puts "Calculator loaded and ready to accept RPN expressions.\n" \
        'Developed by Alex Braha Stoll (http://alexbs.com.br/)'

      loop do
        print '> '
        expr = gets
        expr = expr.chomp if expr
        next if expr == ''
        shutdown if QUIT_COMMANDS.include?(expr)

        begin
          puts @interpreter.interpret(expr)
        rescue StandardError => e
          puts "Error: #{e.message}"
        end
      end
    end

    private

    def handle_relevant_signals
      Signal.trap('INT') { shutdown }
      Signal.trap('TERM') { shutdown }
    end

    def shutdown
      puts "\nQuitting..."
      exit
    end
  end
end
