# Chapter 2 — Parsing Expressions

> Book chapters: [Representing Code](https://craftinginterpreters.com/representing-code.html)
> and [Parsing Expressions](https://craftinginterpreters.com/parsing-expressions.html).
>
> **Status:** overview available; per-stage guides and tests are added next. This
> page gives you the concepts so you can start thinking about the design.

## From a flat list to a tree

The scanner gave you a *flat* sequence of tokens. But `1 + 2 * 3` doesn't *mean*
anything flat — it means "add 1 to the product of 2 and 3". That structure is a
tree:

```
        (+)
       /   \
      1    (*)
          /   \
         2     3
```

**Parsing** is turning the token list into this **Abstract Syntax Tree (AST)** —
a data structure that captures how the pieces nest, with the right **precedence**
(`*` binds tighter than `+`) and **associativity** (`a - b - c` means `(a - b) - c`).

The new command is `parse`, and it prints the AST in a fully-parenthesized,
Lisp-like form so the structure is unambiguous and easy to test:

```
   input              parse output
   1 + 2 * 3     ──▶  (+ 1.0 (* 2.0 3.0))
   -123 * (45.67)──▶  (* (- 123.0) (group 45.67))
   !true         ──▶  (! true)
```

Number literals print as their float value (`1.0`), `true`/`false`/`nil` as
themselves, strings as their contents, a parenthesized expression as
`(group …)`, and a unary/binary operator as `(<op> <operands…>)`.

## Representing the AST in Rust

This is where Rust shines. An expression is a recursive **enum**, and the AST is
just a value of that type. A first sketch:

```rust
enum Expr {
    Literal(Literal),               // numbers, strings, true, false, nil
    Grouping(Box<Expr>),            // ( expression )
    Unary { op: Token, right: Box<Expr> },
    Binary { left: Box<Expr>, op: Token, right: Box<Expr> },
}
```

`Box` is needed because an `Expr` can contain an `Expr` — without the indirection
the type would have infinite size. Printing the AST is then a `match` over the
variants (the book calls this the "AST printer"; it's also a gentle warm-up for
the evaluator in Chapter 3, which is the *same shape* of `match` but returns
values instead of strings).

## How parsing works: recursive descent

You'll write the parser by hand using **recursive descent** — one function per
level of the grammar, where each function calls the next-tighter level. The Lox
expression grammar, loosest to tightest:

```
expression → equality
equality   → comparison ( ( "!=" | "==" ) comparison )*
comparison → term       ( ( ">" | ">=" | "<" | "<=" ) term )*
term       → factor     ( ( "-" | "+" ) factor )*
factor     → unary      ( ( "/" | "*" ) unary )*
unary      → ( "!" | "-" ) unary | primary
primary    → NUMBER | STRING | "true" | "false" | "nil" | "(" expression ")"
```

Read each rule as a function. `term()` parses a `factor`, then while the next
token is `+` or `-`, consumes it and parses another `factor`, folding them into
`Binary` nodes left-to-right (that left-folding is what gives left-associativity).
Because `term` sits *above* `factor` in the call chain, `*` and `/` naturally bind
tighter than `+` and `-` — **precedence falls out of the structure of the
functions**, which is the elegant heart of the technique.

## What the stages will cover

The chapter builds the parser up the same way the grammar nests:

1. Booleans & `nil` → literals → strings & numbers → parentheses (`group`)
2. Unary operators (`!`, `-`)
3. Arithmetic (`*` `/`, then `+` `-`)
4. Comparison and equality operators
5. Syntactic errors (reporting and recovering from malformed input, exit code 65)

A good first move before you start: make sure your scanner returns a `Vec` of
tokens (see the end of the scanning chapter), since the parser walks that list
with a small cursor — exactly like the scanner walked characters.
