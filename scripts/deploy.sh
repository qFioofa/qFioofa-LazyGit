#!/bin/bash
set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/src"
DEST="${XDG_CONFIG_HOME:-$HOME/.config}/lazygit/config.yml"

if [ -L "$DEST" ]; then
  echo "error: $DEST is a symlink (managed by Home Manager)." >&2
  echo "Build the flake that imports this module instead, or override it with" >&2
  echo "--override-input lazygit-config path:$ROOT ." >&2
  exit 1
fi

mkdir -p "$(dirname "$DEST")"

python3 - "$SRC" "$DEST" <<'PY'
import sys, glob, os, yaml

src, dest = sys.argv[1], sys.argv[2]

def merge(a, b):
    for k, v in b.items():
        if isinstance(v, dict) and isinstance(a.get(k), dict):
            merge(a[k], v)
        else:
            a[k] = v
    return a

files = [os.path.join(src, "config.yml")]
files += sorted(f for f in glob.glob(os.path.join(src, "themes", "*.yml"))
                if not f.endswith("palette.yml"))

out = {}
for f in files:
    with open(f) as fh:
        merge(out, yaml.safe_load(fh) or {})

with open(dest, "w") as fh:
    yaml.safe_dump(out, fh, sort_keys=False, allow_unicode=True)
PY
