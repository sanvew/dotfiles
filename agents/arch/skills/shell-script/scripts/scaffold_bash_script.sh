#!/bin/sh
set -eu

usage() {
  cat <<'USAGE'
Usage: scaffold_bash_script.sh <output-path> [script-name]

Create a POSIX `/bin/sh` script template with strict mode and basic argument parsing.
USAGE
}

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  usage
  exit 2
fi

output_path="$1"
script_name="${2:-$(basename "$output_path")}"

if [ -e "$output_path" ]; then
  echo "Refusing to overwrite existing file: $output_path" >&2
  exit 1
fi

mkdir -p "$(dirname "$output_path")"

cat >"$output_path" <<'EOF'
#!/bin/sh
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"

usage() {
  cat <<'USAGE'
Usage: __SCRIPT_NAME__ --config FILE [--minimal]

Options:
  --config FILE Required configuration path
  --minimal     Enable minimal mode
  -h, --help    Show this help message
USAGE
}

enforce_line_width() {
  if awk '
    length($0) > 80 {
      printf "%s:%d:%d\n", FILENAME, NR, length($0)
      bad=1
    }
    END { exit bad }
  ' "$0"; then
    return 0
  fi

  echo "Line length limit exceeded in $0 (max 80 chars)." >&2
  exit 2
}

parse_args() {
  minimal=0
  config=""

  while [ "$#" -gt 0 ]; do
    case "$1" in
      --minimal)
        minimal=1
        ;;
      --config)
        if [ "$#" -lt 2 ]; then
          echo "Missing value for --config" >&2
          usage
          exit 2
        fi
        config="$2"
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
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
}

main() {
  enforce_line_width
  parse_args "$@"

  echo "__SCRIPT_NAME__: implement main logic (config=$config minimal=$minimal)"
}

main "$@"
EOF

escaped_script_name="$(printf '%s' "$script_name" | sed 's/[\/&]/\\&/g')"
tmp_file="$(mktemp)"
sed "s/__SCRIPT_NAME__/$escaped_script_name/g" "$output_path" >"$tmp_file"
mv "$tmp_file" "$output_path"

chmod +x "$output_path"
echo "Created $output_path"
