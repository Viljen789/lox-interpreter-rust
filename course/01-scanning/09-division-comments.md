# Stage 09 · Division operator & comments

**Goal:** `/` is `SLASH`, but `//` starts a comment that runs to end of line and
produces **no token**.

## What's new

Lookahead that *discards* input instead of producing a two-char token. When `/`
is followed by another `/`, everything until the next newline (or EOF) is a
comment and is thrown away.

## Your task

- `/` (not followed by `/`) → `SLASH / null`
- `//` → consume the rest of the line, emit nothing for it.

Example — input `(()// comment`:

```
LEFT_PAREN ( null
LEFT_PAREN ( null
RIGHT_PAREN ) null
EOF  null
```

A line that is only `// this is a comment` produces just `EOF  null`.

## Hints

<details><summary>Hint 1 — detect the comment</summary>

When you read `/`, peek. If the next char is also `/`, you're in a comment;
otherwise emit `SLASH`.
</details>

<details><summary>Hint 2 — skip to end of line</summary>

For a comment, keep consuming characters while the next one is neither `\n` nor
end-of-input. Don't consume the `\n` itself — let your normal newline handling
deal with it (it'll matter for line counting in stage 11). With a `Peekable`,
that's a `while let Some(&c) = chars.peek()` loop that breaks on `'\n'`.
</details>

## Reflection

- A comment is the first thing your scanner *recognizes but does not emit*.
  Whitespace (next stage) is the same. What's the general category here — input
  that's meaningful to *humans* but irrelevant to the *parser*?

Next: [10-whitespace.md](10-whitespace.md).
