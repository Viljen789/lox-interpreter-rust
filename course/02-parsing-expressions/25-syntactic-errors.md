# Stage 25 · Syntactic errors

**Goal:** detect malformed expressions, report an error, and exit with code `65`.
This completes the Parsing chapter.

## What's new

So far you've assumed well-formed input. Now handle the cases that *aren't*: a
missing operand, a missing `)`, a stray operator. When the parser can't continue,
it reports a **syntax error** and the program exits `65` (the same "input was
wrong" code the scanner used).

## Your task

For malformed input, print nothing to stdout and exit with code **65**:

| input | why it's an error |
|---|---|
| `(72 +)` | `+` has no right-hand operand |
| `(72` | missing closing `)` |
| `* 5` | `*` with no left operand |

(The tests check the **exit code** is `65`. Printing a helpful message to stderr
is good practice — the conventional Lox format is
`[line N] Error at '<token>': <message>` — but the exact wording isn't checked
here, so you have freedom in how you word it.)

## Hints

<details><summary>Hint 1 — where errors surface</summary>

Two places fail naturally:
- **`primary()`** runs out of options — the current token can't start an
  expression (like `)` or `+` or end-of-input). That's an "Expect expression."
  error.
- **`consume()`** is told the next token *must* be something (like `)`) and it
  isn't. That's an "Expect ')' after expression." error.
</details>

<details><summary>Hint 2 — propagating the failure in Rust</summary>

The book throws an exception. In Rust, the idiomatic translation is to make your
parsing functions return `Result<Expr, ParseError>` and use the `?` operator to
bubble failures up to `main`, which then exits `65`. (A simpler first pass: track
a `had_error` flag and return an `Option`/sentinel — but `Result` + `?` is the
clean version and good Rust practice.)
</details>

<details><summary>Hint 3 — synchronization (optional, but worth knowing)</summary>

The book adds `synchronize()` — after an error, skip tokens until a likely
statement boundary so one mistake doesn't cascade into dozens of bogus errors.
You don't strictly need it to pass this stage (a single expression has nowhere to
recover *to*), but read the section: it's the same "report all errors, don't stop
at the first" idea from the scanner, and you'll want it once you parse multiple
statements in Chapter 4.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§6.3 Syntax Errors](https://craftinginterpreters.com/parsing-expressions.html#syntax-errors)
  (error reporting, panic mode, `synchronize()`).
- Rust: [error handling with `Result` and `?`](https://doc.rust-lang.org/book/ch09-02-recoverable-errors-with-result.html)
  — the natural Rust replacement for the book's exceptions.

## 🎉 Chapter 2 complete

When `./test.sh` shows all of `02-parsing-expressions` green, you have a full
recursive-descent parser for Lox expressions, with correct precedence,
associativity, and error handling. The front end is done.

Next comes Chapter 3 — **Evaluating Expressions** — where you walk this exact AST
and produce values. The `match`-over-`Expr` shape you used in the AST printer
becomes the evaluator; `(+ 1.0 2.0)` stops being a string and starts being `3`.
(Stages and tests for Chapter 3 are added next — see
[../03-evaluating-expressions/00-overview.md](../03-evaluating-expressions/00-overview.md)
when it lands.)
