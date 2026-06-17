# Stage 15 · Reserved words

**Goal:** recognize Lox's keywords as their own token types — the last scanning
stage.

## What's new

Keywords like `if`, `while`, `true` look exactly like identifiers to the scanner.
The trick: scan the whole word as if it were an identifier, *then* check whether
it's one of the reserved words. If so, emit the keyword token; otherwise it's a
plain `IDENTIFIER`. (This is much simpler and faster than trying to match keywords
character-by-character.)

## Your task

After reading a word, map it to a keyword token if it's reserved:

| keyword | token | keyword | token |
|---|---|---|---|
| `and` | `AND` | `or` | `OR` |
| `class` | `CLASS` | `print` | `PRINT` |
| `else` | `ELSE` | `return` | `RETURN` |
| `false` | `FALSE` | `super` | `SUPER` |
| `for` | `FOR` | `this` | `THIS` |
| `fun` | `FUN` | `true` | `TRUE` |
| `if` | `IF` | `var` | `VAR` |
| `nil` | `NIL` | `while` | `WHILE` |

Each prints as `<TYPE> <lexeme> null`, e.g. `and` → `AND and null`.

Example — input `var greeting and farewell`:

```
VAR var null
IDENTIFIER greeting null
AND and null
IDENTIFIER farewell null
EOF  null
```

(`greeting` and `farewell` aren't keywords, so they stay identifiers.)

## Hints

<details><summary>Hint 1 — scan first, classify second</summary>

Don't add keyword logic to your character loop. Reuse the identifier scanning from
stage 14 to get the full word, then do a lookup on the finished string.
</details>

<details><summary>Hint 2 — the lookup</summary>

A `match word.as_str() { "and" => …, "class" => …, _ => IDENTIFIER }` is the
straightforward approach and reads clearly. (A `HashMap` also works but is
overkill for 16 fixed words.) The `_` arm is your existing identifier case.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§4.7 Reserved Words and Identifiers](https://craftinginterpreters.com/scanning.html#reserved-words-and-identifiers)
  (scan the whole word first, *then* look it up — maximal munch).

## Reflection

- "Maximal munch" matters here: `orchid` must be one `IDENTIFIER`, not `or` +
  `chid`. Because you scan the *entire* word before checking the keyword table,
  you get this for free. Why would matching keywords character-by-character (as
  soon as you saw `o`-`r`) get this wrong?

## 🎉 Chapter 1 complete

When `./test.sh` shows all 15 scanning stages green, you have a **complete,
correct Lox scanner** — the first phase of the front end, done. Commit it.

Before Chapter 2 (Parsing), there's one design change worth making. Right now you
probably *print* each token as you scan it. The parser, though, needs to walk the
tokens forward (and occasionally peek ahead), so it wants them as a **list**.
Refactor your scan routine to collect tokens into a `Vec` and return it, then move
the printing into the `tokenize` command. That single change turns your scanner
from a one-shot printer into a reusable component the parser can sit on top of.

Then read [../02-parsing-expressions/00-overview.md](../02-parsing-expressions/00-overview.md).
