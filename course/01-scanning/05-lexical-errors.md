# Stage 05 · Lexical errors

**Goal:** report unexpected characters on stderr and exit with code `65` — while
still printing all the valid tokens.

## What's new

Your first **error handling**, and the **exit-code contract**. A character the
scanner doesn't recognize (like `@`, `#`, `$`) is a lexical error. Lox does *not*
stop at the first one: it reports each, keeps scanning, and fails at the end.

## Your task

When you hit a character that matches none of your token rules:

1. Print to **stderr**, exactly: `[line N] Error: Unexpected character: <char>`
   (line `N` is `1` for now — real line tracking arrives in stage 11).
2. Keep scanning the rest of the input.
3. Still print every valid token to **stdout**, plus the final `EOF  null`.
4. After scanning, if there was **any** error, exit with code **65**.

Example — input `,.@(` →

stdout:
```
COMMA , null
DOT . null
LEFT_PAREN ( null
EOF  null
```
stderr:
```
[line 1] Error: Unexpected character: @
```
exit code: `65`.

## Run it

```sh
./test.sh
```

(The harness checks stdout, stderr, *and* the exit code for these cases.)

## Hints

<details><summary>Hint 1 — stdout vs stderr</summary>

`println!` writes to stdout; `eprintln!` writes to stderr. Tokens go to stdout,
errors to stderr. They're separate streams, so their relative order doesn't
matter to the tests — only the contents of each.
</details>

<details><summary>Hint 2 — remembering that an error happened</summary>

You need to remember "did anything go wrong?" across the whole scan so `main` can
choose the exit code. A `bool` works — either a field on your scanner struct
(`had_error`) that you flip on, with a getter `main` checks, or returning a flag
out of your scan function. Don't `process::exit` from deep inside the scanner;
let `main` own the exit.
</details>

<details><summary>Hint 3 — why 65?</summary>

`65` is the Unix `EX_DATAERR` convention ("the input data was incorrect"). It's
the code _Crafting Interpreters_ uses for scan/parse errors, and the tests assert
on it. A successful run exits `0`.
</details>

## Reflection

- Reporting *all* errors instead of stopping at the first is a deliberate UX
  choice. Can you imagine an input where "keep going after an error" produces a
  confusing *cascade* of follow-on errors? (You'll see this tension again in the
  parser, where the fix is called "synchronization".)

Next: [06-assignment-equality.md](06-assignment-equality.md).
