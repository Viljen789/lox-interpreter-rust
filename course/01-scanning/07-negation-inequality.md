# Stage 07 · Negation & inequality operators

**Goal:** `!` (`BANG`) and `!=` (`BANG_EQUAL`).

## What's new

The same one-char-lookahead pattern as stage 6, now for `!`. If you wrote a
"match next char" helper, this stage is two lines.

## Your task

| input | token |
|---|---|
| `!` | `BANG ! null` |
| `!=` | `BANG_EQUAL != null` |

Example — input `!!===`:

```
BANG ! null
BANG ! null
EQUAL_EQUAL == null
EQUAL = null
EOF  null
```

(Read `!!===`: `!`, `!`, then `==`, then `=`.)

## Hints

<details><summary>Hint — reuse</summary>

This is structurally identical to `=`/`==`. If you're copy-pasting the peek
logic, that's the signal to extract the helper from stage 6's hint 2 and call it
here with the target char `'='`.
</details>

## Reflection

- `!=` and `==` both end in `=`. Your scanner peeked at the `=` *after* the first
  character. Why is one character of lookahead enough for every operator in Lox,
  but not enough to scan a number like `123.456`? (Foreshadowing stage 13.)

Next: [08-relational.md](08-relational.md).
