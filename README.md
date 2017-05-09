# Reverse Polish Notation

This gem implements a Reverse Polish Notation calculator that supports the basic
four arithmetic operators (+, -, * and /). It also includes a CLI utility.

![](https://cl.ly/0G0S2z3J193J/download/Screen%20Recording%202017-05-09%20at%2012.15%20AM.gif)

## Installation

1. Clone this Git repository:
```
git clone git@github.com:alexbrahastoll/exp-rpn.git
```

2. Install the gem's dependencies:
```
bundle install
```

**Heads up:** This gem was developed using the most recent Ruby version at the
time of its release (i.e. MRI 2.4.1). It may work with older versions, however
it is recommended that you also use 2.4.1.

3. Run the specs to make sure everything is working great (all tests should pass):
```
bundle exec rspec
```

## Usage

After downloading and installing the gem, fire up the CLI with the following command:
`./exe/rpn`

Then, have fun doing crazy arithmetic operations in RPN =)

## Architectural choices and trade-offs

**High-level overview**

When you input an expression using the CLI, this is what basically happens:

1. `RPN::Interpreter#interpret` gets called receiving the expression. The interpreter
removes extra whitespaces from the expression and then goes through each potential
token (values and operators).
2. Each `RPN::Value` or `RPN::Operator` receives an `apply_to` message, causing
the appropriate changes to the stack (an instance of `RPN::Stack` injected at the
moment of the interpreter's initialization).
3. After all the values and operators were processed, the last value pushed to the
stack gets returned as a string.

My intention was to implement the RPN calculator using a good OO design. I do think
I was able to achieve that objective. The objects that are part of the solution
are cohesive and loosely coupled. As a consequence, it seems that it would be really
easy to extend this solution. For example, we could execute the following with
little effort:

- Make the calculator available in a Rails application by using this gem.
Since the rest of the solution does not depend on the CLI, we could easily
send to the interpreter messages coming from an HTML form for example;

- It would be relatively straightforward to implement basic unary operators (e.g. the factorial)

**Possible improvements**

- This gem has a very good test coverage (98.9%), however I chose not to write unit tests
for `RPN::Stack` and `RPN::CLI` because they are very simple objects. `RPN::Stack` is also being decently tested indirectly in other specs. If this project
was to continue growing, I would very much likely also add unit tests to these classes.

- To deal with errors, I am using exceptions. I think returning value objects might be
a better solution however (because it seems we would have to deal with even more error
scenarios if we were to add new features to the calculator). If I were to devote more
time to this solution, I would probably experiment with value objects and refactor the code
that currently use exceptions.
