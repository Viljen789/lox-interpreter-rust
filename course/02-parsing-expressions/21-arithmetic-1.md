# Stage 21 · Arithmetic operators (1/2): `*` and `/`

**Goal:** parse multiplication and division — your first **binary** operators.

## What's new

Binary operators are **left-associative**: `1 / 2 / 3` means `(1 / 2) / 3`, not
`1 / (2 / 3)`. You get that with a **loop**, not recursion: parse one operand,
then while you keep seeing the operator, fold the next operand into the left side.

## Your task

| input | output |
|---|---|
| `16 * 38` | `(* 16.0 38.0)` |
| `16 * 38 / 58` | `(/ (* 16.0 38.0) 58.0)` |
| `1 / 2 / 3` | `(/ (/ 1.0 2.0) 3.0)` |

## Hints

<details><summary>Hint 1 — the rule</summary>

```
factor → unary ( ( "/" | "*" ) unary )*
```

Parse a `unary` into `expr`. Then `while` the next token is `*` or `/`: consume
the operator, parse another `unary` as the right side, and **reassign**
`expr = Binary { left: expr, op, right }`. The reassignment-into-left is what makes
it left-associative.
</details>

<details><summary>Hint 2 — the AST variant</summary>

`Binary { left: Box<Expr>, op: Token, right: Box<Expr> }`. The printer renders it
`(<op> <left> <right>)`. Make `expression()` call `factor()` now (it sits above
`unary` in the chain).
</details>

<details><summary>Hint 3 — trace the loop</summary>

For `16 * 38 / 58`: parse `16`; see `*`, parse `38`, `expr = (* 16 38)`; see `/`,
parse `58`, `expr = (/ (* 16 38) 58)`; no more operators, return. That nesting is
exactly the expected output.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§6.2 Recursive Descent Parsing](https://craftinginterpreters.com/parsing-expressions.html#recursive-descent-parsing),
  the `factor()` rule. The book derives the `( … )*` loop-for-left-associativity
  pattern carefully — worth reading slowly; you'll reuse it for the next three
  stages.

## Reflection

- Unary used recursion (right-associative); binary uses a loop (left-associative).
  What would `1 / 2 / 3` print if you *recursed* on the right operand instead of
  looping? Why is that wrong for division?

Next: [22-arithmetic-2.md](22-arithmetic-2.md).
