#!/bin/sh

set -euo pipefail
tmpdir="$(mktemp -d)" && trap 'rm -rf "$tmpdir"' EXIT
case "$(uname -m)" in
  x86_64) asset_arch="amd64" ;;
  aarch64) asset_arch="arm64" ;;
  armv7l|armhf) asset_arch="arm" ;;
  *) echo "Unsupported architecture for lf release: $arch" >&2; exit 1 ;;
esac
curl -fsSL "https://github.com/gokcehan/lf/releases/latest/download/lf-linux-${asset_arch}.tar.gz" -o "$tmpdir/lf.tar.gz"
tar -xzf "$tmpdir/lf.tar.gz" -C "$tmpdir"
install -m 755 "$tmpdir/lf" /usr/local/bin/lf
