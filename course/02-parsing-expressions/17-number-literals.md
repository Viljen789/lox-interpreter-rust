# Stage 17 · Number literals

**Goal:** parse number literals and print their value.

## What's new

One more case in `primary`: a `NUMBER` token becomes a literal. The printed form
is the number's **value** as a float — the same `42 → 42.0` formatting you used in
the scanner's literal column.

## Your task

| input | output |
|---|---|
| `42.47` | `42.47` |
| `1234.5678` | `1234.5678` |
| `6` | `6.0` |
| `0.0` | `0.0` |

## Hints

<details><summary>Hint 1 — reuse the token's literal value</summary>

Your `NUMBER` token already carries the parsed `f64` from Chapter 1. `primary`
just wraps it: `Expr::Literal(Number(value))`. No re-parsing needed.
</details>

<details><summary>Hint 2 — the printing format</summary>

Same rule as the scanner: an integer-valued number prints with a trailing `.0`.
Rust's `{:?}` on an `f64` gives `6.0` and `42.47` correctly; plain `{}` would
print `6`, which is wrong here.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§6.2 Recursive Descent Parsing](https://craftinginterpreters.com/parsing-expressions.html#recursive-descent-parsing),
  the `primary()` rule (NUMBER and STRING).
- Recall [§4.6.2 Number literals](https://craftinginterpreters.com/scanning.html#number-literals)
  for why the value is an `f64`.

## Reflection

- The scanner already parsed `"6"` into the `f64` `6.0`. Why is it good design for
  the scanner to do that once, rather than the parser (or evaluator) re-parsing
  the text later?

Next: [18-string-literals.md](18-string-literals.md).
