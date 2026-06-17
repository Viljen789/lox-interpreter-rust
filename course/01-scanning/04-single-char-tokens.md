# Stage 04 · Other single-character tokens

**Goal:** recognize the remaining single-character tokens.

## What's new

A batch of one-char tokens that never need lookahead:

| char | token type |
|---|---|
| `.` | `DOT` |
| `,` | `COMMA` |
| `+` | `PLUS` |
| `-` | `MINUS` |
| `;` | `SEMICOLON` |
| `*` | `STAR` |

(`/` is *not* here — it needs lookahead to tell a division from a `//` comment,
which is stage 9.)

## Your task

Emit the matching token for each, e.g. `*` → `STAR * null`.

Example — input `+-*.,;`:

```
PLUS + null
MINUS - null
STAR * null
DOT . null
COMMA , null
SEMICOLON ; null
EOF  null
```

## Run it

```sh
./test.sh
```

## Hints

<details><summary>Hint — keep it boring</summary>

Six more `match` arms. If you find yourself wanting to avoid the repetition, hold
that thought — but don't over-engineer a scanner this small. Clarity beats
cleverness here.
</details>

## Reflection

- The token *type* (`STAR`) and the *lexeme* (`*`) are different things that
  happen to look similar for operators. For which upcoming tokens will the lexeme
  and type be very different? (Think `NUMBER` and `IDENTIFIER`.)

Next: [05-lexical-errors.md](05-lexical-errors.md).
