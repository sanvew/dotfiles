---
name: shell-script
description: Create, refactor, harden, and debug portable POSIX shell scripts for automation and CLI tooling. Use when work involves `.sh` files, `/bin/sh` command wrappers, argument parsing, environment variables, safe file operations, pipelines, cron/CI scripts, or shell-specific troubleshooting across varied systems.
---

# Shell Script
Use this skill to implement reliable scripts quickly and avoid common shell footguns.

## Workflow
1. Determine target shell first.
Choose `#!/bin/sh` by default for maximum portability and avoid Bash-specific syntax.

2. Define script contract before coding.
List required arguments, optional flags, expected environment variables, inputs, outputs, and non-zero exit conditions.

3. Start from the scaffold.
Run `scripts/scaffold_bash_script.sh <path/to/script.sh> [script-name]` to generate a strict-mode template.

4. Implement command execution safely.
Quote expansions consistently, avoid `eval`, and keep syntax strictly POSIX-compliant.

5. Validate early.
Run `scripts/validate_bash_script.sh <script1.sh> [script2.sh ...]` after each substantial change.

## Implementation Rules
- Use `#!/bin/sh` as the script header.
- Enable portable strict mode with `set -eu`.
- Determine script directory with `SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"` when resolving relative paths.
- Name function arguments at function start (for example `config_path=$1; shift`) instead of using raw `$1`, `$2` throughout the body.
- Quote every variable expansion unless intentional word splitting is required.
- Use `"$@"` for forwarding arguments.
- Use `mktemp -d` and `trap` for temporary files and cleanup.
- Keep side-effectful operations behind explicit checks.
- Return meaningful exit codes and write errors to stderr.
- Exit with status `2` for usage errors, including missing mandatory arguments.
- Avoid non-POSIX features (`[[ ]]`, arrays, `function` keyword, process substitution, `pipefail`).
- Avoid interactive/dynamic input (`read`/readline-style prompts); pass inputs through args, env vars, or files.

## Debugging Rules
- Use `sh -n` for syntax checks before runtime checks.
- Use `shellcheck` when available.
- Add focused traces with `set -x` around suspicious blocks.
- Log failed commands with function wrappers instead of broad, noisy tracing.

## Resource Map
- Read [references/shell-patterns.md](references/shell-patterns.md) for robust idioms and decision rules.
- Use [scripts/scaffold_bash_script.sh](scripts/scaffold_bash_script.sh) to generate new script skeletons.
- Use [scripts/validate_bash_script.sh](scripts/validate_bash_script.sh) to run repeatable checks.
