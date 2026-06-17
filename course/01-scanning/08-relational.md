# Stage 08 · Relational operators

**Goal:** `<`, `<=`, `>`, `>=`.

## What's new

Two more pairs that follow the exact lookahead pattern.

## Your task

| input | token |
|---|---|
| `<` | `LESS < null` |
| `<=` | `LESS_EQUAL <= null` |
| `>` | `GREATER > null` |
| `>=` | `GREATER_EQUAL >= null` |

Example — input `<<=>>=`:

```
LESS < null
LESS_EQUAL <= null
GREATER > null
GREATER_EQUAL >= null
EOF  null
```

## Hints

<details><summary>Hint — last of the lookahead operators</summary>

After this, every "peek for a trailing `=`" operator is done (`==`, `!=`, `<=`,
`>=`). If your helper made these four lines each, your scanner's `match` is
staying clean. Stage 9's `/` is the last operator needing lookahead, and it's a
bit different.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§4.5.2 Operators](https://craftinginterpreters.com/scanning.html#operators).

## Reflection

- You now have a `match` arm per operator. Roughly how many distinct token types
  have you defined so far? Glance at your token enum — is it growing in a way you
  can still read at a glance?

Next: [09-division-comments.md](09-division-comments.md).
