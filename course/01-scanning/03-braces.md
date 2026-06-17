# Stage 03 · Braces

**Goal:** recognize `{` and `}`.

## What's new

Nothing conceptually — it's two more single-character tokens. The point is to see
that adding a token kind is now a one-line change to your `match`.

## Your task

`{` → `LEFT_BRACE { null` and `}` → `RIGHT_BRACE } null`.

Example — input `{}`:

```
LEFT_BRACE { null
RIGHT_BRACE } null
EOF  null
```

## Run it

```sh
./test.sh
```

## Hints

<details><summary>Hint — Rust char literal for a brace</summary>

`'{'` and `'}'` are perfectly valid `char` literals; no escaping needed. Just add
two more arms to your `match`.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§4.5 Recognizing Lexemes](https://craftinginterpreters.com/scanning.html#recognizing-lexemes).

## Reflection

- If adding a token now means editing one `match` and one `Display`/print site,
  your design is in good shape. If it means editing five places, that's a smell —
  worth noticing early.

Next: [04-single-char-tokens.md](04-single-char-tokens.md).
