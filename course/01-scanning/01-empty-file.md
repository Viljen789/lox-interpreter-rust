# Stage 01 · Empty file

**Goal:** tokenizing an empty file prints exactly one line — `EOF  null` — and
exits with code `0`.

## What's new

This is the skeleton everything else hangs off. There are no real tokens yet; the
job is to wire up the pipeline: `main` already reads the file into a `source`
string and dispatches the `tokenize` command to you. You produce output and a
correct exit code.

## Your task

For **any** empty input, print:

```
EOF  null
```

That's the End-Of-File token. Note the **two spaces** between `EOF` and `null` —
the EOF token has an empty lexeme, so the middle field is blank:
`EOF` + space + `<empty lexeme>` + space + `null`.

Exit code must be `0`.

## Run it

```sh
./test.sh                 # builds, runs, points you here
./run.sh tokenize tests/01-scanning/01-empty-file/empty.lox
```

Right now `src/main.rs` has a `todo!()` in the `tokenize` arm, so the harness
reports a panic. Replace it.

## Hints

<details><summary>Hint 1 — how to start</summary>

You don't need a loop yet. The `tokenize` arm in `src/main.rs` just needs to
print the EOF line. But think one step ahead: in the next stage you'll loop over
characters. A clean shape is a separate scanner — e.g. a `lexer` module with a
function that takes `&source` and prints tokens. Set that up now even though it
does almost nothing.
</details>

<details><summary>Hint 2 — the module split</summary>

A common structure:
- `src/main.rs` — parses args, reads the file, calls into your scanner, sets the
  exit code.
- `src/lexer.rs` (declare it with `mod lexer;` in `main.rs`) — owns a `Token`
  type and the scanning function.

For this stage the scanner can literally just `println!("EOF  null")`.
</details>

<details><summary>Hint 3 — the two-space gotcha</summary>

If your test shows a `stdout` diff where the lines *look* identical, you probably
have one space instead of two. The format is `EOF` `<space>` `<lexeme>` `<space>`
`null`, and EOF's lexeme is the empty string — so it's `"EOF  null"` with two
spaces. A raw string literal makes this easy to get exactly right.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§4.1 The Interpreter Framework](https://craftinginterpreters.com/scanning.html#the-interpreter-framework)
  and [§4.4 The Scanner Class](https://craftinginterpreters.com/scanning.html#the-scanner-class)
  (the scan loop and the trailing EOF token).

## Reflection

- Why does an interpreter bother emitting an explicit EOF token instead of just
  stopping? (Hint: think about what the *parser* will want when it asks "is there
  anything left to read?")

When `./test.sh` shows `✓ 01-scanning/01-empty-file`, commit and go to
[02-parentheses.md](02-parentheses.md).
