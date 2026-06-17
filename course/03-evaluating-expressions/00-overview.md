# Chapter 3 — Evaluating Expressions

> Book chapter: [Evaluating Expressions](https://craftinginterpreters.com/evaluating-expressions.html).
>
> **Status:** overview available; per-stage guides and tests are added next. This
> page gives you the concepts and the design decisions to think about first.

## From a tree to a value

Chapter 2 turned tokens into an AST. Now you **walk** that tree and compute a
result — this is what makes it a *tree-walking interpreter*. The new command is
`evaluate`, which evaluates a single expression and prints its value:

```
   evaluate              result
   1 + 2 * 3      ──▶    7
   3 < 5          ──▶    true
   "a" + "b"      ──▶    ab
   !nil           ──▶    true
```

The evaluator has the **same shape** as your AST printer: a `match` over `Expr`.
The difference is it returns a *value* instead of a string. (If your printer was
clean, the evaluator will feel familiar — the structure carries over directly.)

## Lox values

Expressions produce runtime values. Lox has four types, which you'll model as a
Rust enum:

```rust
enum Value {
    Number(f64),
    Str(String),
    Bool(bool),
    Nil,
}
```

A few semantics to get right:

- **Truthiness.** Only `false` and `nil` are falsey. *Everything else is truthy* —
  including `0` and `""`. (This matters for `!` and, later, `if`/`while`.)
- **Number stringification — a gotcha.** When you *evaluate*, integers print
  **without** a trailing `.0`: `42` prints as `42`, and `42.5` as `42.5`. This is
  different from `tokenize`/`parse`, where the literal value showed as `42.0`. The
  book's `stringify` strips a trailing `.0`. Watch for this — it's a common
  early test failure.
- **Equality.** `==` compares values; values of different types are never equal
  (`2 == "2"` is `false`), and `nil` equals only `nil`.

## Runtime errors and exit code 70

Some expressions parse fine but are nonsense to *evaluate*: `-"muffin"`,
`"a" < 1`, `true * 3`. These are **runtime errors**. When one happens you report
it to stderr (conventionally `<message>\n[line N]`) and exit with code **70** —
distinct from the `65` you used for scan/parse errors. Keep the two straight:

| code | meaning | phase |
|---|---|---|
| 65 | input was malformed | scanning, parsing |
| 70 | well-formed but failed at runtime | evaluating |

In Rust, a `Result<Value, RuntimeError>` threaded through your evaluator with `?`
is the clean way to propagate these up to `main`.

## What the stages will cover

Literals → grouping → unary (`-`, `!`) → arithmetic (`*` `/`, then `+` `-`) →
string concatenation (`+` on two strings) → relational (`<` `<=` `>` `>=`) →
equality (`==` `!=`) → and then the runtime-error cases for each operator group.

## 📖 Where to look

- _Crafting Interpreters_ — [§7.2 Evaluating Expressions](https://craftinginterpreters.com/evaluating-expressions.html#evaluating-expressions)
  (the evaluator), [§7.3 Runtime Errors](https://craftinginterpreters.com/evaluating-expressions.html#runtime-errors),
  and [§7.4 Hooking Up the Interpreter](https://craftinginterpreters.com/evaluating-expressions.html#hooking-up-the-interpreter)
  (including `stringify`, the number-formatting rule above).
- Rust: [`Result` and the `?` operator](https://doc.rust-lang.org/book/ch09-02-recoverable-errors-with-result.html)
  for runtime-error propagation.
