# Stage 14 · Identifiers

**Goal:** scan identifiers — names like `foo`, `_bar`, `x123`.

## What's new

An identifier starts with a letter or underscore and continues with letters,
digits, or underscores. Same "read until a boundary" shape as numbers and strings.

## Your task

- On a letter (`a`–`z`, `A`–`Z`) or `_`, consume the whole word.
- Emit `IDENTIFIER <lexeme> null`. (The literal is `null` — an identifier's
  meaning comes later, from the environment; the scanner just records the name.)

Example — input `foo bar _hello`:

```
IDENTIFIER foo null
IDENTIFIER bar null
IDENTIFIER _hello null
EOF  null
```

And `_` on its own is a valid identifier: `IDENTIFIER _ null`.

## Hints

<details><summary>Hint 1 — the start vs the rest</summary>

The *first* character may be a letter or `_` (not a digit — that would start a
number). *Subsequent* characters may also include digits. So the continue-rule is
"alphanumeric or `_`". Rust's `char::is_alphanumeric` and an `== '_'` check cover it.
</details>

<details><summary>Hint 2 — careful with ranges</summary>

A range pattern like `'a'..='z' | 'A'..='Z' | '_'` matches the first character.
For the inner loop deciding where the word ends, `c.is_alphanumeric() || c == '_'`
is the clean predicate.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§4.7 Reserved Words and Identifiers](https://craftinginterpreters.com/scanning.html#reserved-words-and-identifiers).

## Reflection

- The scanner can't know whether `foo` is a variable, a function, or undefined —
  that's the interpreter's job much later. So why bother classifying it as
  `IDENTIFIER` now instead of leaving it as raw text? What does giving it a token
  type buy the parser?

Next: [15-reserved-words.md](15-reserved-words.md).
