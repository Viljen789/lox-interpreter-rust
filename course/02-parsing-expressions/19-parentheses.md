# Stage 19 · Parentheses

**Goal:** parse parenthesized expressions into a `group` node.

## What's new

Your first **recursive** grammar rule, and your first **non-leaf** AST node. When
`primary` sees a `(`, it parses a *whole expression* inside, then expects a `)`.
The result prints as `(group <inner>)`.

## Your task

| input | output |
|---|---|
| `("hello")` | `(group hello)` |
| `(42.47)` | `(group 42.47)` |
| `((true))` | `(group (group true))` |

## Hints

<details><summary>Hint 1 — the rule</summary>

`primary → "(" expression ")"`. On a `LEFT_PAREN`: consume it, call your top-level
`expression()` (which currently bottoms out at `primary`), then **consume** the
`RIGHT_PAREN`. Wrap the inner `Expr` in a `Grouping` variant.
</details>

<details><summary>Hint 2 — recursion is the whole point</summary>

Calling `expression()` from inside `primary()` is what makes `((true))` work: the
inner `(true)` is itself a grouping. You don't write loops for nesting — the call
stack handles it. Add a `Grouping(Box<Expr>)` variant (the `Box` is needed because
`Expr` now contains an `Expr` — without indirection the type would be infinitely
sized).
</details>

<details><summary>Hint 3 — consuming the ')'</summary>

You need a helper that asserts "the next token must be `X`, advance past it." For
now you can assume inputs are well-formed; in stage 25 you'll make this helper
report a proper error when the `)` is missing.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§6.2 Recursive Descent Parsing](https://craftinginterpreters.com/parsing-expressions.html#recursive-descent-parsing),
  the `(` case of `primary()` and the `consume()` helper.
- Rust: [recursive types and `Box`](https://doc.rust-lang.org/book/ch15-01-box.html#enabling-recursive-types-with-boxes)
  — exactly the "a type that contains itself" situation you hit here.

## Reflection

- `(group (group true))` came out of a single recursive `primary` calling
  `expression` calling `primary` again. Trace the call stack for `((true))`. Where
  does the nesting "depth" live — in your data, or in the recursion?

Next: [20-unary.md](20-unary.md).
