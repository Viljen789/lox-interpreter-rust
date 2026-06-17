# Stage 22 · Arithmetic operators (2/2): `+` and `-`

**Goal:** parse addition and subtraction — and get operator **precedence** right.

## What's new

`+` and `-` bind *looser* than `*` and `/`. In recursive descent that means the
`term` rule sits **above** `factor` and calls it for its operands. Precedence
isn't special-cased anywhere — it's purely the order in which the rules call each
other.

## Your task

| input | output |
|---|---|
| `1 + 2` | `(+ 1.0 2.0)` |
| `1 + 2 - 3` | `(- (+ 1.0 2.0) 3.0)` |
| `1 + 2 * 3` | `(+ 1.0 (* 2.0 3.0))` |

That last one is the payoff: `2 * 3` groups *before* the `+`, with no extra code —
just because `term` calls `factor`.

## Hints

<details><summary>Hint 1 — the rule</summary>

```
term → factor ( ( "-" | "+" ) factor )*
```

Identical shape to stage 21, one level up: parse a `factor`, then loop while the
next token is `+` or `-`, folding into a left-associative `Binary`. Point
`expression()` at `term()` now.
</details>

<details><summary>Hint 2 — see the precedence work</summary>

For `1 + 2 * 3`: `term` parses its first `factor`, which is `1` (factor sees no
`*`/`/` after `1`). Then `term` sees `+`, and parses another `factor` for the right
side — and *that* factor consumes `2 * 3` as a unit. So `+` ends up with `(* 2 3)`
on its right. The call hierarchy did the precedence for you.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§6.2 Recursive Descent Parsing](https://craftinginterpreters.com/parsing-expressions.html#recursive-descent-parsing),
  the `term()` rule, and re-read the grammar table at the top of the chapter: the
  rules are listed **lowest precedence first**, each calling the next-higher one.

## Reflection

- You now have `term → factor → unary → primary`. If you wanted to add an
  exponent operator `^` that binds *tighter* than `*` but looser than unary, where
  in that chain would its rule go, and which rules would change?

Next: [23-comparison.md](23-comparison.md).
