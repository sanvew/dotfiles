#!/bin/sh
set -eu

usage() {
  cat <<'USAGE'
Usage: validate_bash_script.sh <script1.sh> [script2.sh ...]

Validate POSIX shell scripts with syntax checks and shellcheck (if available).
USAGE
}

if [ "$#" -lt 1 ]; then
  usage
  exit 2
fi

status=0
has_shellcheck=0
if command -v shellcheck >/dev/null 2>&1; then
  has_shellcheck=1
fi

for script_path in "$@"; do
  if [ ! -f "$script_path" ]; then
    echo "Missing file: $script_path" >&2
    status=1
    continue
  fi

  echo "Checking $script_path"
  if ! sh -n "$script_path"; then
    status=1
  fi

  if [ "$has_shellcheck" -eq 1 ]; then
    if ! shellcheck -s sh "$script_path"; then
      status=1
    fi
  else
    echo "shellcheck not found; skipping lint step for $script_path"
  fi
done

exit "$status"
