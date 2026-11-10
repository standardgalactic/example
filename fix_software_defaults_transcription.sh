#!/usr/bin/env bash
set -euo pipefail
# Run from the directory containing the two transcript files, or pass that directory.
DIR="${1:-.}"
BASE='How_software_defaults_steal_developer_credit'
python3 - "$DIR" "$BASE" <<'PY'
from pathlib import Path
import sys, re, shutil
folder, base = Path(sys.argv[1]), sys.argv[2]
# Exact, conservative corrections. No factual rewriting or paraphrasing.
changes = [
 ('click a lay from the screen', 'click away from the screen'),
 ('one drive integration', 'OneDrive integration'),
 ('yes, backup my files', 'yes, back up my files'),
 ('H-key current user', 'HKEY_CURRENT_USER'),
 ('D-word values', 'DWORD values'),
 ('brick your home and bean', 'brick your home machine'),
 ('XF data', 'EXIF data'),
 ('strong form of resigned credit', 'strong form of assigned credit'),
 ('ClaudeCode', 'Claude Code'),
 ('code base', 'codebase'),
 ('co-authored by trailer', 'Co-authored-by trailer'),
 ('co-authored by trailers', 'Co-authored-by trailers'),
 ('co-authored by colon clod', 'Co-authored-by: Claude'),
 ('operated by colon clod', 'Operated-by: Claude'),
 ('chat GPT images', 'ChatGPT images'),
 ('Anthropix', 'Anthropic'),
 ('Anthropik', 'Anthropic'),
 ("Torvald's account", "Torvalds' account"),
 ('an inactive humans\' handle', "an inactive human's handle"),
 ('Or are automated agents are endlessly warring', 'Or are automated agents endlessly warring'),
 ('Log4J', 'Log4j'),
 ('H-key current user paths', 'HKEY_CURRENT_USER paths'),
]
for suffix in ('.txt', '.vtt'):
    path = folder / (base + suffix)
    if not path.is_file():
        sys.exit(f'Missing required file: {path}')
    raw = path.read_bytes()
    content = raw.decode('utf-8-sig')
    revised = content
    counts = []
    for old, new in changes:
        n = revised.count(old)
        if n:
            revised = revised.replace(old, new)
            counts.append((old, new, n))
    if revised == content:
        print(f'{path.name}: no changes needed')
        continue
    backup = path.with_name(path.name + '.bak')
    if not backup.exists():
        shutil.copy2(path, backup)
    # Retain UTF-8 BOM if present, as well as original line endings.
    encoded = revised.encode('utf-8-sig' if raw.startswith(b'\xef\xbb\xbf') else 'utf-8')
    path.write_bytes(encoded)
    print(f'{path.name}: {sum(n for _,_,n in counts)} corrections; backup: {backup.name}')
    for old, new, n in counts:
        print(f'  {n}x {old!r} -> {new!r}')
PY
