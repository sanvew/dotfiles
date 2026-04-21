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
Usage: my-script --config FILE [--minimal]
USAGE
}

minimal=0
config=""
while [ "$#" -gt 0 ]; do
  case "$1" in
    --minimal) minimal=1 ;;
    --config)
      if [ "$#" -lt 2 ]; then
        echo "Missing value for --config" >&2
        usage
        exit 2
      fi
      config="$2"
      shift
      ;;
    -h|--help) usage; exit 0 ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 2
      ;;
  esac
  shift
done

if [ -z "$config" ]; then
  echo "Missing required argument: --config FILE" >&2
  usage
  exit 2
fi
```

- Reject unknown flags early.
- Exit `2` if a required option value is missing.
- Exit `2` for usage errors.
- Exit `2` when mandatory arguments are not provided.

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
