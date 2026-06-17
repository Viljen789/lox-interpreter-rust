#!/bin/sh
# Run your interpreter locally against a Lox file, e.g.:
#   ./run.sh tokenize test.lox
#   ./run.sh parse test.lox
set -e
exec cargo run --quiet --release -- "$@"
