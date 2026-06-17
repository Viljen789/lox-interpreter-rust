# Stage 18 · String literals

**Goal:** parse string literals and print their contents.

## What's new

The last literal kind: a `STRING` token becomes a literal whose printed form is
the string **contents** (no quotes).

## Your task

| input | output |
|---|---|
| `"hello"` | `hello` |
| `"foo bar"` | `foo bar` |
| `"with 123 + symbols"` | `with 123 + symbols` |

Note the last one: inside a string, `123` and `+` are just characters — the
scanner already captured them as the string's contents, so the parser treats the
whole thing as one literal.

## Hints

<details><summary>Hint — same shape as numbers</summary>

Add a `STRING` arm to `primary` that wraps the token's string value in
`Expr::Literal(Str(...))`. The printer outputs the raw contents — no quotes, no
escaping.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§6.2 Recursive Descent Parsing](https://craftinginterpreters.com/parsing-expressions.html#recursive-descent-parsing),
  `primary()`. In the book these literal cases all collapse into one
  `Expr.Literal(previous().literal)`; in Rust you'll likely have a small enum of
  literal kinds, which is fine and arguably clearer.

## Reflection

- All four literal kinds (`true`/`false`/`nil`, numbers, strings) hit the same
  `primary` rule. They're the **leaves** of the AST. Every other rule you add from
  here builds *internal nodes* that ultimately bottom out at these leaves. Why
  does that make `primary` the right place for them?

Next: [19-parentheses.md](19-parentheses.md).
