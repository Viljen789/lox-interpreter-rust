# Stage 12 · String literals

**Goal:** scan `"..."` string literals, and report unterminated strings.

## What's new

Your first token whose lexeme spans an arbitrary number of characters, and your
first token with a real **literal value**. A string runs from an opening `"` to
the next `"`. If the input ends before the closing `"`, that's an error.

## Your task

- On `"`, consume characters until the closing `"`.
- Emit: `STRING <lexeme> <literal>` where the **lexeme includes the quotes** and
  the **literal is the contents without quotes**.
- If you reach end-of-input with no closing `"`, report
  `[line N] Error: Unterminated string.` on stderr and exit `65` (no token for it).

Examples:

| input | output line |
|---|---|
| `"hello"` | `STRING "hello" hello` |
| `"foo bar baz"` | `STRING "foo bar baz" foo bar baz` |

Input `"unterminated` (no closing quote) → stderr `[line 1] Error: Unterminated string.`,
exit `65`, and stdout is just `EOF  null`.

## Hints

<details><summary>Hint 1 — the inner loop</summary>

After consuming the opening `"`, loop: peek; if it's `"`, you found the end (consume
it and stop); if it's end-of-input, it's unterminated; otherwise push the char onto
the string contents and consume it.
</details>

<details><summary>Hint 2 — two strings to build</summary>

You need both the **contents** (`hello`) for the literal and you know the **lexeme**
is just the contents wrapped in quotes (`"hello"`). Store the contents; you can
produce the lexeme by adding the quotes back when you print, or store both.
</details>

<details><summary>Hint 3 — multi-line strings</summary>

Lox strings may contain newlines. If you see a `\n` inside a string, still count
it toward your line number (from stage 11) before pushing it. Not all tests
exercise this, but it's correct behavior and cheap to get right.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§4.6.1 String literals](https://craftinginterpreters.com/scanning.html#string-literals)
  (consume to the closing quote; unterminated is an error).

## Reflection

- For operators, the token's *type* told you everything. For a string, two
  different inputs (`"a"` and `"b"`) share the type `STRING` but carry different
  *values*. How are you attaching that value to the token? (In Rust, an enum
  variant that holds data — like `String(String)` — is the idiomatic answer.)

Next: [13-number-literals.md](13-number-literals.md).
