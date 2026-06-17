# Stage 11 · Multi-line errors

**Goal:** track the current line so error messages report the right line number.

## What's new

Until now every error said `[line 1]`. Real programs span many lines, and a good
error points at the right one. You'll keep a line counter, starting at `1`,
incremented every time you consume a `\n`.

## Your task

Maintain a line number; when you report an unexpected character, use the line the
character is actually on.

Example — input (three lines; the `@` is on line 2):
```
()
	@
(
```
stdout:
```
LEFT_PAREN ( null
RIGHT_PAREN ) null
LEFT_PAREN ( null
EOF  null
```
stderr:
```
[line 2] Error: Unexpected character: @
```
exit: `65`.

## Hints

<details><summary>Hint 1 — where to count</summary>

You already gave `'\n'` its own `match` arm in stage 10. Make it `line += 1`.
Keep `line` as state your error-reporting code can read (a field on your scanner
struct is the natural home).
</details>

<details><summary>Hint 2 — off-by-one checks</summary>

Increment *when you consume* the newline, not before. A character on line 2 should
be reported as line 2, which means the newline ending line 1 was already counted.
Start the counter at `1`, not `0`.
</details>

## Reflection

- Right now the line number is used only for error messages and then forgotten.
  When you build the parser, a syntax error on line 30 will also want a line
  number — but the parser sees *tokens*, not characters. What does that imply you
  might need to store *on each token*? (You don't have to do it yet — just notice
  the future requirement.)

Next: [12-string-literals.md](12-string-literals.md).
