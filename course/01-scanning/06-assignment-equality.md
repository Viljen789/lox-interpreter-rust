# Stage 06 · Assignment & equality operators

**Goal:** distinguish `=` (`EQUAL`) from `==` (`EQUAL_EQUAL`).

## What's new

**One character of lookahead.** When you see `=`, you can't decide yet — you must
peek at the *next* character. If it's another `=`, the two together form `==`
(and you consume both). Otherwise it's a lone `=`. This is maximal munch in
action.

## Your task

| input | token |
|---|---|
| `=` | `EQUAL = null` |
| `==` | `EQUAL_EQUAL == null` |

Example — input `={===}`:

```
EQUAL = null
LEFT_BRACE { null
EQUAL_EQUAL == null
EQUAL = null
RIGHT_BRACE } null
EOF  null
```

(Read `{===}`: `{`, then `==`, then `=`, then `}`. Maximal munch takes the `==`
first, leaving a single `=`.)

## Hints

<details><summary>Hint 1 — peek without consuming</summary>

With a `Peekable` iterator, `chars.peek()` returns `Option<&char>` *without*
advancing. If it's `Some('=')`, emit `EQUAL_EQUAL` and call `chars.next()` to
actually consume that second `=`. Otherwise emit `EQUAL`.
</details>

<details><summary>Hint 2 — a helper pays off</summary>

You're about to write this exact "if the next char is `=`, two-char token, else
one-char token" logic three more times (stages 7 and 8). A small helper — "if
next char matches `x`, consume it and return true" — will make those stages
trivial. Worth writing now.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§4.5.2 Operators](https://craftinginterpreters.com/scanning.html#operators)
  (two-character operators and the `match()` helper for one-char lookahead).

## Reflection

- `EQUAL_EQUAL`'s lexeme is `==` (two chars) but it came from two separate
  characters in the source. How are you building that two-character lexeme string
  for the output?

Next: [07-negation-inequality.md](07-negation-inequality.md).
