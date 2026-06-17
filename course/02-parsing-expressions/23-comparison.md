# Stage 23 · Comparison operators

**Goal:** parse `<`, `<=`, `>`, `>=`.

## What's new

Another precedence level, looser than `+`/`-`: the `comparison` rule sits above
`term`. Same loop pattern as the last two stages.

## Your task

| input | output |
|---|---|
| `1 < 2` | `(< 1.0 2.0)` |
| `83 < 99 < 115` | `(< (< 83.0 99.0) 115.0)` |
| `5 >= 4` | `(>= 5.0 4.0)` |

## Hints

<details><summary>Hint — the rule</summary>

```
comparison → term ( ( ">" | ">=" | "<" | "<=" ) term )*
```

You've written this shape three times now; it's becoming muscle memory. Parse a
`term`, loop over the four comparison operators, fold left. Point `expression()`
at `comparison()`.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§6.2 Recursive Descent Parsing](https://craftinginterpreters.com/parsing-expressions.html#recursive-descent-parsing),
  the `comparison()` rule. By now you'll notice every binary rule is *the same
  function with different operator tokens* — some people factor this into a helper
  that takes the operators and the next rule. Try it if the repetition bugs you
  (but a little duplication here is perfectly readable too).

## Reflection

- `83 < 99 < 115` parses fine into `(< (< 83 99) 115)` — but think ahead to
  Chapter 3: when you *evaluate* it, `83 < 99` becomes `true`, and then you'd
  compare `true < 115`. What should happen then? (Lox makes that a runtime error;
  parsing it is still valid.)

Next: [24-equality.md](24-equality.md).
