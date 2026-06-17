# Building an Interpreter in Rust

A hands-on project for learning how programming languages are implemented. You
build a complete interpreter for **Lox** — a small dynamically-typed language —
in Rust, one concept at a time, with a test suite that checks each step.

The goal is understanding. By the end you'll have written, from scratch, every
stage of a language's front end and runtime:

- **Lexical analysis (scanning)** — turning source text into a stream of tokens
- **Parsing** — turning tokens into an Abstract Syntax Tree (AST) with correct
  operator precedence and associativity, via recursive descent
- **Evaluation** — walking the AST to produce values (a tree-walking interpreter)
- **State & environments** — variables, assignment, lexical scope
- **Control flow** — conditionals, logical operators, loops
- **Functions & closures** — call frames, first-class functions, captured scope
- **Resolution & binding** — a static pass that fixes variable resolution
- **Classes & inheritance** — instances, methods, `this`, constructors, `super`

These are the same ideas behind real compilers and interpreters; a tree-walking
interpreter is the clearest way to learn the front end (scanner, parser, AST)
before tackling heavier machinery like bytecode and code generation.

## The pipeline

```
   source text          tokens              syntax tree (AST)        values
   "1 + 2 * 3"   ──▶   1  +  2  *  3   ──▶        (+ 1            ──▶    7
                                              (* 2 3))
                    ▲                      ▲                       ▲
                 SCANNING               PARSING               EVALUATING
              (lexical analysis)    (recursive descent)    (tree-walking)
```

Each stage of the project drives one of these arrows. The interpreter is invoked
with a command that stops at a given stage, so you can build and test
incrementally:

```sh
./run.sh tokenize program.lox   # source → tokens
./run.sh parse    program.lox   # tokens → AST (printed)
./run.sh evaluate program.lox   # evaluate a single expression
./run.sh run      program.lox   # run a full program
```

## How to work through it

1. **Run the tests:** `./test.sh`. It builds the interpreter and reports the
   first stage that doesn't pass yet — that's where you are.
2. **Read that stage's guide** under [`course/`](course/). Each one explains the
   concept, then specifies exactly what input must produce what output.
3. **Implement it** in [`src/`](src/). The design is yours.
4. **Re-run `./test.sh`**, read the diff, iterate until the stage is green.
5. **Commit**, and move to the next stage.

The tests are the spec: they tell you precisely what "correct" looks like, so you
get tight, immediate feedback the way you would from a compiler's own test suite.

## Layout

| Path | What |
|---|---|
| [`src/`](src/) | The interpreter. Starts as a stub; you grow it. |
| [`course/`](course/) | One guide per stage + the full [curriculum map](course/progress.md). |
| [`tests/`](tests/) | Test cases (`.lox` input + expected output). See [tests/README.md](tests/README.md). |
| `test.sh` | The local test runner. |
| `run.sh` | Run the interpreter by hand on a file. |

## The Lox language

Lox is the teaching language from Robert Nystrom's freely-available book
[_Crafting Interpreters_](https://craftinginterpreters.com/), which this project
follows. It's dynamically typed, with one number type (a 64-bit float),
booleans, `nil`, strings, variables, functions and closures, and classes with
single inheritance. Small enough to finish, rich enough to teach the real ideas.

The book is an excellent companion read — but its sample code is in Java.
Translating the concepts into Rust (enums for the AST, pattern matching for
evaluation, ownership for environments) is part of the learning here, not
something to copy.

## Requirements

- Rust (`cargo`) 1.95+
- A POSIX shell with `diff` and `awk` (standard on macOS and Linux)

Start with [`course/README.md`](course/README.md), then run `./test.sh`.
