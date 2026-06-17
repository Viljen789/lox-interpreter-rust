# Stage 13 · Number literals

**Goal:** scan number literals like `42` and `1234.1234`.

## What's new

Numbers have a lexeme (the raw text) *and* a literal value (a 64-bit float). Lox
has only one number type — `f64` — so the integer `42` has the value `42.0`.

## Your task

- On a digit, consume the run of digits. Allow a single `.` followed by more
  digits for the fractional part.
- Emit `NUMBER <lexeme> <literal>` where the lexeme is the exact source text and
  the literal is that text parsed as an `f64` and printed so it **always shows a
  decimal point**.

| input | output line |
|---|---|
| `42` | `NUMBER 42 42.0` |
| `1234.1234` | `NUMBER 1234.1234 1234.1234` |
| `5.4321` | `NUMBER 5.4321 5.4321` |

So `42` keeps its lexeme `42` but prints its value as `42.0`.

## Hints

<details><summary>Hint 1 — recognizing digits</summary>

A range pattern works nicely: `'0'..='9' => { … }`. Inside, accumulate digits the
same way you accumulated string contents — peek, and while the next char is a
digit, consume and push it.
</details>

<details><summary>Hint 2 — the decimal point</summary>

Allow exactly one `.`, and only if it's part of the number. The simple version:
once you've read the integer digits, if the next char is `.`, consume it and read
the fractional digits. (The fully-correct rule requires a digit *after* the dot —
i.e. `123.` should be `NUMBER 123` then `DOT`. One peek isn't enough to see past
the dot; you may want two characters of lookahead, or to read the `.` only when
the char after it is a digit. The provided tests don't push on this edge, but
it's worth getting right.)
</details>

<details><summary>Hint 3 — printing the float</summary>

Parse the lexeme with `.parse::<f64>()`. For printing, you need `42` → `42.0` but
`1234.1234` → `1234.1234`. Rust's `{:?}` (Debug) formatting of an `f64` does
exactly this — it always includes a decimal point. Try it: `format!("{:?}", 42.0_f64)`
gives `"42.0"`. (Plain `{}` / Display gives `"42"`, which is *wrong* here.)
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§4.6.2 Number literals](https://craftinginterpreters.com/scanning.html#number-literals)
  (note the two characters of lookahead — `peek()` and `peekNext()` — for the
  fractional part).

## Reflection

- Why does Lox use a single float type for all numbers instead of separate ints
  and floats? What does that simplify in the interpreter — and what does it cost
  you as a language user? (JavaScript made the same choice.)

Next: [14-identifiers.md](14-identifiers.md).
