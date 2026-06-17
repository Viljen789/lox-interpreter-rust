#!/usr/bin/env bash
#
# Local test harness for the "Build your own Interpreter" course.
# It mirrors the CodeCrafters feedback loop: it runs YOUR interpreter against
# each stage's cases and reports pass/fail with a diff when something's off.
#
# USAGE
#   ./test.sh                Run every stage in order; stop at the first failure.
#                            That first failing stage is "your current stage".
#   ./test.sh <pattern>      Run only stages whose path matches <pattern>, e.g.
#                            ./test.sh scanning      ./test.sh 05      ./test.sh string
#   ./test.sh all            Run every stage; don't stop at the first failure.
#
# ENV
#   BIN=/path/to/binary      Use a prebuilt binary instead of `cargo build`.
#   NO_COLOR=1               Disable colored output.
#
# A "stage" is a directory tests/<chapter>/<stage>/ containing:
#   cmd            one line: the subcommand to run (tokenize | parse | evaluate | run)
#   <name>.lox     an input program
#   <name>.out     its expected stdout         (optional; defaults to empty)
#   <name>.err     its expected stderr         (optional; only checked if present)
#   <name>.exit    its expected exit code      (optional; defaults to 0)

set -u
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

# ── colors ────────────────────────────────────────────────────────────────
if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
  RED=$'\033[31m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'
  BOLD=$'\033[1m'; DIM=$'\033[2m'; RESET=$'\033[0m'
else
  RED=; GREEN=; YELLOW=; BOLD=; DIM=; RESET=
fi
PASS="${GREEN}✓${RESET}"; FAIL="${RED}✗${RESET}"

# ── build (or use a prebuilt BIN) ───────────────────────────────────────────
if [ -n "${BIN:-}" ]; then
  BINARY="$BIN"
  [ -x "$BINARY" ] || { echo "${RED}BIN is not executable: $BINARY${RESET}"; exit 2; }
else
  printf '%s' "${DIM}Building (cargo build --release)… ${RESET}"
  if ! cargo build --release --quiet 2>build.log; then
    echo "${RED}${BOLD}build failed:${RESET}"
    cat build.log; rm -f build.log
    exit 2
  fi
  rm -f build.log
  echo "${DIM}done.${RESET}"
  BINARY="$ROOT/target/release/lox"
fi

# ── args ────────────────────────────────────────────────────────────────────
PATTERN="${1:-}"
STOP_AT_FIRST=1
[ "$PATTERN" = "all" ] && { PATTERN=""; STOP_AT_FIRST=0; }
[ -n "$PATTERN" ] && STOP_AT_FIRST=0

# ── discover stages (sorted by the shell's glob order) ──────────────────────
stages=()
for d in tests/*/*/ ; do
  [ -d "$d" ] || continue
  hit=0
  for f in "$d"*.lox; do [ -e "$f" ] && { hit=1; break; }; done
  [ "$hit" -eq 1 ] || continue
  sd="${d%/}"
  if [ -n "$PATTERN" ]; then
    case "$sd" in *"$PATTERN"*) ;; *) continue ;; esac
  fi
  stages+=("$sd")
done

if [ "${#stages[@]}" -eq 0 ]; then
  echo "${YELLOW}No stages found${PATTERN:+ matching '$PATTERN'}. (Have I added them yet?)${RESET}"
  exit 0
fi

tmperr="$(mktemp)"; tmprep="$(mktemp)"; tmpa="$(mktemp)"; tmpb="$(mktemp)"
trap 'rm -f "$tmperr" "$tmprep" "$tmpa" "$tmpb"' EXIT

# Print a unified, colored diff between expected and actual text (indented).
print_diff() {
  printf '   %s%s%s %s(- expected, + your output)%s\n' "$YELLOW" "$1" "$RESET" "$DIM" "$RESET"
  printf '%s\n' "$2" > "$tmpa"
  printf '%s\n' "$3" > "$tmpb"
  diff -u "$tmpa" "$tmpb" 2>/dev/null | tail -n +3 \
    | awk -v r="$RED" -v g="$GREEN" -v d="$DIM" -v x="$RESET" '
        /^@@/ {print "     " d $0 x; next}
        /^-/  {print "     " r $0 x; next}
        /^\+/ {print "     " g $0 x; next}
              {print "     " $0}'
}

passed=0; failed=0; first_failing=""

for stage in "${stages[@]}"; do
  name="${stage#tests/}"
  cmd="tokenize"; [ -f "$stage/cmd" ] && cmd="$(cat "$stage/cmd")"

  stage_ok=1; : > "$tmprep"
  for lox in "$stage"/*.lox; do
    [ -e "$lox" ] || continue
    base="${lox%.lox}"
    exp_out=""; [ -f "$base.out" ] && exp_out="$(cat "$base.out")"
    exp_err=""; have_err=0; [ -f "$base.err" ] && { exp_err="$(cat "$base.err")"; have_err=1; }
    exp_exit=0; [ -f "$base.exit" ] && exp_exit="$(cat "$base.exit")"

    act_out="$("$BINARY" "$cmd" "$lox" 2>"$tmperr")"; act_code=$?
    act_err="$(cat "$tmperr")"

    bad=""
    [ "$act_out" != "$exp_out" ] && bad="${bad} stdout"
    [ "$have_err" -eq 1 ] && [ "$act_err" != "$exp_err" ] && bad="${bad} stderr"
    [ "$act_code" != "$exp_exit" ] && bad="${bad} exit"
    [ -z "$bad" ] && continue

    stage_ok=0
    {
      printf '\n   %scase%s %s   %scmd%s %s\n' "$DIM" "$RESET" "$lox" "$DIM" "$RESET" "$cmd"
      case "$bad" in *stdout*) print_diff "stdout" "$exp_out" "$act_out" ;; esac
      case "$bad" in *stderr*) print_diff "stderr" "$exp_err" "$act_err" ;; esac
      case "$bad" in *exit*)   printf '   %sexit%s expected %s, got %s\n' "$YELLOW" "$RESET" "$exp_exit" "$act_code" ;; esac
      if [ "$act_code" = "101" ] && printf '%s' "$act_err" | grep -q 'panicked'; then
        printf '   %s↳ your program panicked — likely an unfinished todo!() or an out-of-bounds index.%s\n' "$DIM" "$RESET"
      fi
    } >> "$tmprep"
  done

  if [ "$stage_ok" -eq 1 ]; then
    echo "$PASS $name"; passed=$((passed + 1))
  else
    echo "$FAIL ${BOLD}$name${RESET}"; cat "$tmprep"
    failed=$((failed + 1))
    [ -z "$first_failing" ] && first_failing="$name"
    [ "$STOP_AT_FIRST" -eq 1 ] && break
  fi
done

echo ""
if [ -n "$first_failing" ]; then
  echo "${BOLD}${passed} passing${RESET}${DIM}, ${failed} failing.${RESET}"
  echo "${YELLOW}${BOLD}→ Current stage: ${first_failing}${RESET}"
  echo "${DIM}  Read course/${first_failing}.md, make it pass, then run ./test.sh again.${RESET}"
  exit 1
else
  echo "${GREEN}${BOLD}All ${passed} stage(s) passing 🎉${RESET}"
  exit 0
fi
