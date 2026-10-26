#!/bin/sh
set -eu

usage() {
  cat <<'USAGE'
Usage: scaffold_bash_script.sh [-h] <output-path> [script-name]

Create a POSIX `/bin/sh` script template with strict mode, usage, and
getopts-based argument parsing.

Options:
  -h  Show this help message
USAGE
}

OPTIND=1
while getopts 'h' opt; do
  case "$opt" in
    h) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
done
shift $((OPTIND - 1))

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  usage >&2
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
Usage: __SCRIPT_NAME__ -c FILE [-m] [-h]

Options:
  -c FILE  Required configuration path
  -m       Enable minimal mode
  -h       Show this help message
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

  if [ "$#" -gt 0 ]; then
    echo "Unexpected operand: $1" >&2
    usage >&2
    exit 2
  fi

  if [ -z "$config" ]; then
    echo "Missing required option: -c FILE" >&2
    usage >&2
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
