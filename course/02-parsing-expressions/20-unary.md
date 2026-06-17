# Stage 20 · Unary operators

**Goal:** parse the unary operators `!` and `-`.

## What's new

A new grammar rule that sits *above* `primary`: `unary`. A unary operator applies
to the expression on its right — and that expression can itself be another unary,
so the rule is **right-recursive**.

## Your task

| input | output |
|---|---|
| `!true` | `(! true)` |
| `-5` | `(- 5.0)` |
| `!!false` | `(! (! false))` |
| `-(-5)` | `(- (group (- 5.0)))` |

## Hints

<details><summary>Hint 1 — the rule</summary>

```
unary → ( "!" | "-" ) unary
      | primary
```

If the current token is `!` or `-`, consume it and recursively call `unary()` for
the operand; build a `Unary { op, right }` node. Otherwise fall through to
`primary()`. Your `expression()` entry point should now call `unary()` instead of
`primary()` directly.
</details>

<details><summary>Hint 2 — why recursion, not a loop</summary>

`!!false` is `!(!false)`. Because `unary()` calls *itself* for the operand, the
nesting falls out naturally — no loop needed. (Contrast this with the *binary*
operators next stage, which are left-associative and *do* use a loop.)
</details>

<details><summary>Hint 3 — add the AST variant</summary>

`Unary { op: Token, right: Box<Expr> }`. The printer renders it as
`(<op-lexeme> <right>)`, e.g. the op token's lexeme `-` gives `(- 5.0)`.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§6.2 Recursive Descent Parsing](https://craftinginterpreters.com/parsing-expressions.html#recursive-descent-parsing),
  the `unary()` rule. Notice how the grammar's structure (which rule calls which)
  encodes precedence — `unary` binds tighter than the binary operators you're
  about to add.

## Reflection

- `-` is both a unary operator (negation, here) and a binary operator
  (subtraction, stage 22). How will your parser tell them apart? (Hint: it's about
  *position* — what has just been parsed when the `-` is seen.)

Next: [21-arithmetic-1.md](21-arithmetic-1.md).
