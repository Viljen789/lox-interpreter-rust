# Chapter 1 — Scanning (the lexer)

> Book chapter: [Scanning](https://craftinginterpreters.com/scanning.html). Read
> it alongside these stages. The book is in Java; you're writing Rust, so
> translate the *ideas*, not the code.

## What you're building

A **scanner** (a.k.a. lexer or tokenizer). It takes raw Lox source — a single
string — and produces a flat list of **tokens**: the "words" of the language.

```
  source text             tokens
  "(1 + 2)"      ──▶    LEFT_PAREN ( null
                        NUMBER 1 1.0
                        PLUS + null
                        NUMBER 2 2.0
                        RIGHT_PAREN ) null
                        EOF  null
```

The `tokenize` command reads a file and prints one token per line, then a final
`EOF  null`. That printed format is the contract the tests check.

## The output format

Every token prints as three space-separated fields:

```
<TYPE> <lexeme> <literal>
```

- **TYPE** — an uppercase name like `LEFT_PAREN`, `STAR`, `STRING`, `NUMBER`.
- **lexeme** — the exact source text of the token (`(`, `*`, `"hi"`, `42`).
- **literal** — the runtime value for literals, or `null` for everything else.
  Strings print their contents (`hi`); numbers print as a float (`42.0`).

The final line is always `EOF  null` — note the **two spaces** (the EOF token has
an empty lexeme, so the field between is blank).

## The core design

One idea drives the whole scanner: **a cursor that reads one character at a time,
with one character of lookahead.** You sit in a loop:

```
take the next character
  ├─ is it a single-char token like '(' or '*'?  →  emit it
  ├─ could it start a two-char token like '=' →  peek: is the next char '='?
  │       yes → emit '=='  (and consume the peeked char)   no → emit '='
  ├─ is it '"' ?   →  read until the closing '"'  (a string)
  ├─ is it a digit?  →  read the whole number
  ├─ is it a letter/underscore?  →  read the whole word, keyword or identifier?
  ├─ is it whitespace?  →  skip it  (newline: also count a line)
  └─ none of the above?  →  it's a lexical error
```

This is **maximal munch**: when several rules could match, consume the *longest*
one. That's why `<=` is one token, not `<` then `=`, and why `orchid` is an
identifier, not the keyword `or` followed by `chid`.

A couple of Rust tools make the cursor natural — but **how** you walk the string
is your design choice. Two common approaches:
- `source.chars().peekable()` — an iterator with `.next()` and `.peek()`. Clean
  and UTF-8-safe, but no random access (you can't easily look backward).
- `Vec<char>` (or the bytes) with an integer index you advance yourself — more
  like the book, gives you `start`/`current` positions for free.

Either works for this chapter. Pick one and run with it.

## Errors and exit codes

Lox doesn't stop at the first bad character. It reports the error to **stderr**,
keeps scanning so it can report *all* errors, and at the very end exits with a
non-zero code. The convention (which the tests check) is:

- Errors go to **stderr**, formatted exactly: `[line N] Error: <message>`
- Valid tokens still print to **stdout** as usual.
- If there was **any** error, the process exits with code **65**. Otherwise `0`.

You'll first need this in stage 5. A clean way to handle it: track a `had_error`
boolean, print errors as you find them, and check it once at the end in `main` to
decide the exit code.

## How the stages build up

Stages 1–4 add token *kinds* one group at a time (parens, braces, the other
single-char tokens). Stage 5 introduces error handling and exit 65. Stages 6–9
add the operators that need one-char lookahead (`=`/`==`, `!`/`!=`, `<`/`<=`,
`/` vs `//` comments). Stages 10–11 handle whitespace and correct line counting.
Stages 12–15 add the "read until a boundary" tokens: strings, numbers,
identifiers, and finally keyword recognition.

By the end you'll have a complete, correct Lox scanner — the foundation the
parser (Chapter 2) builds on.

Start with [01-empty-file.md](01-empty-file.md).
