# Stage 24 · Equality operators

**Goal:** parse `==` and `!=` — the loosest-binding operators, and the new top of
the expression grammar.

## What's new

`equality` sits at the very top: `expression → equality`. Once you add it, your
full expression-grammar chain is complete.

## Your task

| input | output |
|---|---|
| `"baz" == "baz"` | `(== baz baz)` |
| `1 != 2` | `(!= 1.0 2.0)` |
| `1 == 2 != 3` | `(!= (== 1.0 2.0) 3.0)` |

## Hints

<details><summary>Hint — the rule, and finishing the chain</summary>

```
equality → comparison ( ( "!=" | "==" ) comparison )*
```

Same loop pattern. Then make your top-level `expression()` call `equality()`. Your
chain is now:

```
expression → equality → comparison → term → factor → unary → primary
```

Each rule calls the next-tighter one; precedence and associativity are entirely
encoded by that structure.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§6.2 Recursive Descent Parsing](https://craftinginterpreters.com/parsing-expressions.html#recursive-descent-parsing),
  the `equality()` rule and [§6.4 Wiring up the Parser](https://craftinginterpreters.com/parsing-expressions.html#wiring-up-the-parser).
  Your parser now matches the book's complete expression parser.

## Reflection

- Stand back and look at your seven rules. Adding a new operator at any precedence
  is now a *local* change — one rule. Compare that to the alternative of parsing
  with one big function and manual precedence numbers. What did the
  rule-per-precedence structure buy you in readability and extensibility?

Next: [25-syntactic-errors.md](25-syntactic-errors.md).
