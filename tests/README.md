# Tests

The test suite is plain files on disk — no framework. `./test.sh` (in the repo
root) builds the interpreter and runs it against every case, comparing output
byte-for-byte. Adding tests is just adding files, so grow the suite freely.

## Layout

```
tests/<chapter>/<stage>/
    cmd            the subcommand to run for this stage: tokenize | parse | evaluate | run
    <case>.lox     an input program
    <case>.out     expected stdout              (optional — defaults to empty)
    <case>.err     expected stderr              (optional — only checked if present)
    <case>.exit    expected exit code           (optional — defaults to 0)
```

A "stage" is any directory two levels under `tests/` that contains at least one
`.lox` file. Stages run in sorted order, which is why they're numbered
(`01-empty-file`, `02-parentheses`, …).

Each `<case>` is one program. A stage can have any number of cases (`a.lox`,
`b.lox`, …); name them however you like — the `.out`/`.err`/`.exit` files are
matched by the shared base name.

## Example

A stage that checks scanning of parentheses:

```
tests/01-scanning/02-parentheses/
    cmd          → "tokenize"
    a.lox        → "()"
    a.out        → "LEFT_PAREN ( null\nRIGHT_PAREN ) null\nEOF  null"
```

An error case also pins stderr and the exit code:

```
tests/01-scanning/05-lexical-errors/
    cmd          → "tokenize"
    a.lox        → "@"
    a.out        → "EOF  null"
    a.err        → "[line 1] Error: Unexpected character: @"
    a.exit       → "65"
```

## Notes

- Trailing newlines are normalized, so you don't have to be fussy about a final
  `\n` in `.out`/`.err`.
- `stderr` is only checked when a `.err` file exists. For normal output stages,
  just provide `.out`.
- Keep each stage's inputs within the language features introduced up to that
  stage, so a case can be solved with only what's been built so far.

## Running a subset

```sh
./test.sh                 # all stages, stop at the first failure
./test.sh 05              # only stages whose path matches "05"
./test.sh string          # only stages matching "string"
./test.sh all             # everything, don't stop at the first failure
```
