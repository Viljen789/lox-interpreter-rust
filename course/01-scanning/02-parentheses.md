# Stage 02 · Parentheses

**Goal:** recognize `(` and `)` and emit a token for each.

## What's new

Your first real tokens, and your first **loop over characters**. From here on the
scanner walks the source one character at a time and emits a token per meaningful
chunk.

## Your task

For each `(` print `LEFT_PAREN ( null`, and for each `)` print `RIGHT_PAREN ) null`,
in source order — then the usual `EOF  null` at the end.

Example — input `()`:

```
LEFT_PAREN ( null
RIGHT_PAREN ) null
EOF  null
```

## Run it

```sh
./test.sh
```

## Hints

<details><summary>Hint 1 — the loop</summary>

Get a cursor over the characters. With an iterator that's
`let mut chars = source.chars().peekable();` then `while let Some(c) = chars.next() { … }`.
Inside, `match c { … }` on the character. (Or use a `Vec<char>` + index — your call.)
</details>

<details><summary>Hint 2 — emitting</summary>

For now you can `println!` each token directly from the scanner, exactly like
stage 1 printed EOF. (Later, around the parser, you'll want to *collect* tokens
into a `Vec` instead of printing them — but don't worry about that yet.)
</details>

## Reflection

- `(` and `)` are decided by looking at a single character. Which tokens do you
  think will need to look at *two* characters before deciding? (You'll meet them
  in stage 6.)

Green? On to [03-braces.md](03-braces.md).
