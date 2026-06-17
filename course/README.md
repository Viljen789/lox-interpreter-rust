# The Curriculum

This folder is the course: a sequence of **84 stages** across **9 chapters**, each
a small, testable step in building the interpreter. It follows the structure of
_Crafting Interpreters_, from "scan an empty file" to "inheritance with `super`".
The full map is in [progress.md](progress.md).

## How a stage works

Every stage is a tiny increment you can implement and verify on its own. Each
guide has the same shape:

- **Goal** — one sentence.
- **What's new** — the single concept this stage introduces.
- **Your task** — exactly what input must produce what output.
- **Output spec** — the precise format, with examples. The tests check it
  literally, whitespace and all, so treat it as a contract.
- **Hints** — collapsed `<details>` blocks. Open them only if you're stuck, one
  at a time: they nudge you toward the idea rather than handing over code.
- **Reflection** — a question or two to connect the stage to the bigger picture.

You implement it in `src/`, run `./test.sh`, and iterate against the diff until
the stage passes.

## Why it's built this way

The point of the project is to **understand language implementation by writing
it**. So the curriculum gives you the concept and an exact specification, and
leaves the implementation to you — that's where the learning happens. The tests
are an oracle for "is this correct?", which frees you to focus on "how do I make
it correct?".

If you get stuck, the productive path is: re-read the failing test's diff, open
one hint, and reason about the concept — not reach for a finished answer. A
little struggle is the method, not a detour.

## Reading the test output

`./test.sh` prints one line per stage and stops at the first failure:

```
✓ 01-scanning/01-empty-file
✗ 01-scanning/02-parentheses

   case tests/01-scanning/02-parentheses/a.lox   cmd tokenize
   stdout (- expected, + your output)
     @@ -1,3 +1,2 @@
     -LEFT_PAREN ( null
     -RIGHT_PAREN ) null
     +LEFT_PAREN ( null
     ...

0 passing, 1 failing.
→ Current stage: 01-scanning/02-parentheses
```

- Lines starting `-` are the **expected** output; lines starting `+` are **yours**.
- `exit expected X, got Y` flags a wrong process exit code (Lox uses `65` for
  scan/parse errors and `70` for runtime errors — you'll meet these later).
- A "panicked" note means your Rust code crashed: an unfinished `todo!()`, an
  out-of-bounds index, an `.unwrap()` on `None`, and so on.

## The chapters at a glance

1. **Scanning** — lexical analysis: source text → tokens.
2. **Parsing Expressions** — tokens → an AST, with precedence and associativity.
3. **Evaluating Expressions** — a tree-walking evaluator for expressions.
4. **Statements & State** — `print`, expression statements, variables, scope.
5. **Control Flow** — `if`/`else`, logical `and`/`or`, `while`, `for`.
6. **Functions** — declarations, calls, `return`, first-class functions, closures.
7. **Resolving & Binding** — a static resolution pass for correct scoping.
8. **Classes** — declarations, instances, methods, `this`, constructors.
9. **Inheritance** — superclasses, method overriding, `super`.

Chapter 1 is fully built out. Later chapters' guides and tests are added as the
project grows — see each chapter's `00-overview.md` for its concepts.

Ready? Run `./test.sh` and open the stage it points you to, starting with
[01-scanning/00-overview.md](01-scanning/00-overview.md).
