# Shell Patterns

## Contents

1. Shell Selection
2. Safe Script Header
3. Script Directory Pattern
4. Function Argument Naming Pattern
5. Argument Parsing Pattern
6. Safe Command Execution
7. Temporary Files and Cleanup
8. Portability Checklist
9. Troubleshooting Checklist

## Shell Selection
- Use POSIX `sh` when portability across minimal systems is required.
- Default to `/bin/sh` unless there is an explicit requirement for a different shell.
- Do not mix Bash features into POSIX scripts.

## Safe Script Header
```sh
#!/bin/sh
set -eu
```

- Keep header at the top of executable scripts.
- Treat unset variables as failures with `-u`.
- Check pipeline behavior explicitly because `pipefail` is not POSIX.

## Script Directory Pattern
```sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
```

- Use this exact pattern to resolve script-local relative paths portably.
- Prefer `"$SCRIPT_DIR/relative/path"` instead of relying on current working directory.

## Function Argument Naming Pattern
```sh
install_modules() {
  arg1=$1; arg2=$2; arg3=$3; shift 3
  # remaining args available in "$@"
}
```

- Map positional parameters to named variables at function start.
- Use `shift` after consuming required positional parameters.
- Avoid using raw `$1`, `$2`, `$3` throughout long function bodies.

## Argument Parsing Pattern
```sh
usage() {
  cat <<'USAGE'
Usage: my-script -c FILE [-m] [-h] [OPERAND...]

Options:
  -c FILE  Required configuration path
  -m       Enable minimal mode
  -h       Show this help message
USAGE
}

minimal=0
config=""
OPTIND=1
while getopts 'c:mh' opt; do
  case "$opt" in
    c) config=$OPTARG ;;
    m) minimal=1 ;;
    h) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
done
shift $((OPTIND - 1))
# remaining operands available in "$@"

if [ -z "$config" ]; then
  echo "Missing required option: -c FILE" >&2
  usage >&2
  exit 2
fi
```

- Every script has a `usage()` function and an `h` entry in the optstring.
- Use the POSIX `getopts` builtin; never the external `getopt` (GNU and BSD variants are incompatible).
- `getopts` supports short options only; do not emulate long options.
- A `:` after a letter in the optstring means the option takes a value (`$OPTARG`).
- `getopts` reports unknown options and missing values to stderr itself and yields `?`; handle it via `*)` with exit `2`.
- Reset `OPTIND=1` when parsing inside a function; `shift` there only affects the function's own positional parameters.
- `-h` prints usage to stdout and exits `0`; usage errors print usage to stderr and exit `2`.
- Exit `2` when mandatory options or operands are not provided.

## Safe Command Execution
```sh
rsync -av --delete "$src/" "$dst/"
```

- Prefer direct command invocation with quoted parameters.
- Avoid string-built commands and `eval`.

## Temporary Files and Cleanup
```sh
tmp_dir="$(mktemp -d)"
cleanup() { rm -rf "$tmp_dir"; }
trap cleanup EXIT INT TERM
```

- Register cleanup immediately after allocation.
- Avoid predictable temp names.

## Portability Checklist
- Confirm interpreter path exists on target systems.
- Avoid GNU-only flags when portability matters.
- Avoid Bash-only syntax (`[[ ]]`, arrays, process substitution, `pipefail`).
- Avoid dynamic interactive input (`read`, readline-style prompts); accept data via args, env vars, or files.
- Prefer `command -v tool` checks before use.
- Document required external binaries.

## Troubleshooting Checklist
- Run `sh -n script.sh`.
- Run `shellcheck -s sh script.sh` if available.
- Add temporary `set -x` to isolate failing sections.
- Verify quoting around paths with spaces.
- Verify redirections and pipeline exit behavior.
