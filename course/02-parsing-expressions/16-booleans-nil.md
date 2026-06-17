# Stage 16 · Booleans & Nil

**Goal:** add a `parse` command that turns tokens into an AST and prints it.
Start with the three simplest expressions: `true`, `false`, `nil`.

## What's new

This is the **parser skeleton** — the analog of stage 1 for the scanner. You're
standing up a whole new phase, even though it only handles three literals so far.
Four pieces come together:

1. A `parse` command in `main` (alongside `tokenize`).
2. Your scanner returning a **`Vec` of tokens** instead of printing them (the
   refactor flagged at the end of Chapter 1 — do it now if you haven't).
3. An **`Expr`** type: the AST. For now it only needs to represent a literal.
4. An **AST printer**: turns an `Expr` into the parenthesized string the tests check.

## Your task

`./run.sh parse <file>` parses a single expression and prints it. For this stage:

| input | output |
|---|---|
| `true` | `true` |
| `false` | `false` |
| `nil` | `nil` |

## Hints

<details><summary>Hint 1 — the parser is a cursor over tokens</summary>

The scanner walked characters with a position; the parser walks **tokens** the
same way. A `Parser` holding `tokens: Vec<Token>` and a `current: usize` index,
with `peek()`/`advance()`/`check()` helpers, mirrors your scanner exactly.
</details>

<details><summary>Hint 2 — the Expr type</summary>

Model the AST as an `enum Expr`. For this stage a single variant is enough — a
literal that can be a boolean or nil. You'll grow this enum every stage (numbers,
strings, grouping, unary, binary), so pick a shape you can extend. A separate
`enum Literal { Bool(bool), Nil, Number(f64), Str(String) }` inside
`Expr::Literal(Literal)` is one clean option.
</details>

<details><summary>Hint 3 — the one grammar rule you need</summary>

The bottom rule of the expression grammar is `primary`. For now:
`primary → "true" | "false" | "nil"`. In code: look at the current token; if it's
`TRUE`, produce `Expr::Literal(Bool(true))`; and so on. That's the entire parser
for this stage.
</details>

<details><summary>Hint 4 — printing the AST</summary>

Write a function that takes an `&Expr` and returns a `String` by `match`ing on the
variant. `Literal(Bool(true))` → `"true"`, `Literal(Nil)` → `"nil"`. This is the
"AST printer" from the book; it's also a dry run for the evaluator in Chapter 3,
which has the same `match` shape but returns *values*.
</details>

## 📖 Where to look

- _Crafting Interpreters_ — [§5.2 Implementing Syntax Trees](https://craftinginterpreters.com/representing-code.html#implementing-syntax-trees)
  (the `Expr` types) and [§5.4 A (Not Very) Pretty Printer](https://craftinginterpreters.com/representing-code.html#a-not-very-pretty-printer)
  (the printer — your output format).
- [§6.2 Recursive Descent Parsing](https://craftinginterpreters.com/parsing-expressions.html#recursive-descent-parsing)
  — the `primary()` rule and the parser's helper methods.
- Rust: enums and recursive types — [The Rust Book, ch. 6](https://doc.rust-lang.org/book/ch06-00-enums.html).
  The book's Java uses a class hierarchy + Visitor pattern; in Rust an `enum` +
  `match` replaces both, and is much shorter.

## Reflection

- The scanner turned *characters* into *tokens*; the parser turns *tokens* into a
  *tree*. Both are a cursor scanning a sequence. What's the key new capability the
  tree gives you that a flat token list couldn't? (Hint: nesting / structure.)

Next: [17-number-literals.md](17-number-literals.md).
