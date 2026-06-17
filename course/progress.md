# Progress — 84 stages

Tick a box when `./test.sh` shows the stage green. Your **current stage** is the
first unchecked one (the harness finds it for you). Docs and tests for a chapter
are added as you reach it — Chapter 1 is fully available now.

> Status legend: `[ ]` todo · `[x]` passing · 🟢 = docs + tests available now

---

## Chapter 1 — Scanning 🟢
The lexer: turn source text into a flat list of tokens. Command: `tokenize`.
Book: [Scanning](https://craftinginterpreters.com/scanning.html).

- [ ] 01 · Empty file
- [ ] 02 · Parentheses
- [ ] 03 · Braces
- [ ] 04 · Other single-character tokens
- [ ] 05 · Lexical errors
- [ ] 06 · Assignment & equality operators
- [ ] 07 · Negation & inequality operators
- [ ] 08 · Relational operators
- [ ] 09 · Division operator & comments
- [ ] 10 · Whitespace
- [ ] 11 · Multi-line errors
- [ ] 12 · String literals
- [ ] 13 · Number literals
- [ ] 14 · Identifiers
- [ ] 15 · Reserved words

## Chapter 2 — Parsing Expressions
Tokens → an Abstract Syntax Tree; print it in parenthesized form. Command: `parse`.
Book: [Representing Code](https://craftinginterpreters.com/representing-code.html),
[Parsing Expressions](https://craftinginterpreters.com/parsing-expressions.html).

- [ ] 16 · Booleans & Nil
- [ ] 17 · Number literals
- [ ] 18 · String literals
- [ ] 19 · Parentheses
- [ ] 20 · Unary operators
- [ ] 21 · Arithmetic operators (1/2)
- [ ] 22 · Arithmetic operators (2/2)
- [ ] 23 · Comparison operators
- [ ] 24 · Equality operators
- [ ] 25 · Syntactic errors

## Chapter 3 — Evaluating Expressions
Walk the AST and compute values. Command: `evaluate`.
Book: [Evaluating Expressions](https://craftinginterpreters.com/evaluating-expressions.html).

- [ ] 26 · Literals: Booleans & Nil
- [ ] 27 · Literals: Strings & Numbers
- [ ] 28 · Parentheses
- [ ] 29 · Unary operators: Negation & Not
- [ ] 30 · Arithmetic operators (1/2)
- [ ] 31 · Arithmetic operators (2/2)
- [ ] 32 · String concatenation
- [ ] 33 · Relational operators
- [ ] 34 · Equality operators
- [ ] 35 · Runtime errors: Unary operators
- [ ] 36 · Runtime errors: Binary operators (1/2)
- [ ] 37 · Runtime errors: Binary operators (2/2)
- [ ] 38 · Runtime errors: Relational operators

## Chapter 4 — Statements & State
Statements, `print`, variables, assignment, blocks, scope. Command: `run`.
Book: [Statements and State](https://craftinginterpreters.com/statements-and-state.html).

- [ ] 39 · Print: generate output
- [ ] 40 · Print: multiple statements
- [ ] 41 · Expression statements
- [ ] 42 · Variables: declare variables
- [ ] 43 · Variables: runtime errors
- [ ] 44 · Variables: initialize variables
- [ ] 45 · Variables: redeclare variables
- [ ] 46 · Assignment operation
- [ ] 47 · Block syntax
- [ ] 48 · Scopes

## Chapter 5 — Control Flow
`if`/`else`, logical `and`/`or`, `while`, `for`.
Book: [Control Flow](https://craftinginterpreters.com/control-flow.html).

- [ ] 49 · If statements
- [ ] 50 · Else statements
- [ ] 51 · Else-if statements
- [ ] 52 · Nested if statements
- [ ] 53 · Logical OR operator
- [ ] 54 · Logical AND operator
- [ ] 55 · While statements
- [ ] 56 · For statements
- [ ] 57 · Syntactic errors

## Chapter 6 — Functions
Native functions, declarations, calls, `return`, closures.
Book: [Functions](https://craftinginterpreters.com/functions.html).

- [ ] 58 · Native functions
- [ ] 59 · Functions without arguments
- [ ] 60 · Functions with arguments
- [ ] 61 · Syntax errors
- [ ] 62 · Return statements
- [ ] 63 · Higher order functions
- [ ] 64 · Runtime errors
- [ ] 65 · Function scope
- [ ] 66 · Closures

## Chapter 7 — Resolving & Binding
A resolution pass for correct, fast variable binding.
Book: [Resolving and Binding](https://craftinginterpreters.com/resolving-and-binding.html).

- [ ] 67 · Identifier resolution
- [ ] 68 · Self initialization
- [ ] 69 · Variable redeclaration
- [ ] 70 · Invalid return

## Chapter 8 — Classes
Class declarations, instances, fields, methods, `this`, constructors.
Book: [Classes](https://craftinginterpreters.com/classes.html).

- [ ] 71 · Class declarations
- [ ] 72 · Class instances
- [ ] 73 · Getters & setters
- [ ] 74 · Instance methods
- [ ] 75 · The `this` keyword
- [ ] 76 · Invalid usages of `this`
- [ ] 77 · Constructor calls
- [ ] 78 · Return within constructors

## Chapter 9 — Inheritance
Superclasses, method inheritance & overriding, `super`.
Book: [Inheritance](https://craftinginterpreters.com/inheritance.html).

- [ ] 79 · Class hierarchy
- [ ] 80 · Inheriting methods
- [ ] 81 · Overriding methods
- [ ] 82 · Inheritance errors
- [ ] 83 · The `super` keyword
- [ ] 84 · Invalid usages of the `super` keyword
