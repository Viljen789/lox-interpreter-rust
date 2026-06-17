# Stage 10 · Whitespace

**Goal:** ignore spaces, tabs, and carriage returns between tokens.

## What's new

Whitespace separates tokens but isn't a token itself. Spaces (` `), tabs (`\t`),
and carriage returns (`\r`) are simply skipped. Newlines (`\n`) are skipped too —
but you'll start *counting* them next stage, so handle `\n` as its own case.

## Your task

Skip whitespace; emit tokens for everything else as before.

Example — input `(\t)\n{ }` (tab after `(`, newline, spaces around braces):

```
LEFT_PAREN ( null
RIGHT_PAREN ) null
LEFT_BRACE { null
RIGHT_BRACE } null
EOF  null
```

## Hints

<details><summary>Hint — match several chars to one arm</summary>

In a Rust `match`, you can handle several characters with one arm using `|`:
`' ' | '\t' | '\r' => { /* do nothing */ }`. Give `'\n'` its own arm now (even if
it also does nothing yet) — in stage 11 that arm will increment a line counter.
</details>

## Reflection

- Your scanner now throws away whitespace and comments but keeps everything else.
  The tokens you emit are a *lossy* compression of the source — you couldn't
  perfectly reconstruct the original text from them. Is that a problem for an
  interpreter? When *would* it matter? (Think: code formatters, which must keep
  whitespace.)

Next: [11-multiline-errors.md](11-multiline-errors.md).
