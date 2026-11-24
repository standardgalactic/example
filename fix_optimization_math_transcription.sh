#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
python3 - <<'PY'
from pathlib import Path
import re, shutil
stem = 'The_Hidden_Trapdoors_of_Optimization_Math'
# Conservative corrections of clearly misheard names and phrases.
fixes = [
    (r'\bthe trapdoor of Leish and Highlights\b', 'the trapdoor Flyxion highlights'),
    (r'\bFlachin models\b', 'Flyxion models'),
    (r'\bPachaki\b', 'Pachocki'),
    (r'\bopen AI researcher\b', 'OpenAI researcher'),
    (r'\bmostly pros\b', 'mostly prose'),
    (r'\bon big venues\b', 'on big menus'),
    (r'\bsearch wider area\b', 'search a wider area'),
    (r'\bThat with pure math\b', 'Not with pure math'),
    (r'\bthe continuity assumption\b', 'the continuity assumption'),
    (r'\bverification and capacity drops\b', 'verification capacity drops'),
    (r'\bthe real actual best option\b', 'the actual best option'),
    (r'\bdecision making\b', 'decision-making'),
    (r'\bdata set\b', 'dataset'),
    (r'\bfeel-good local project\b', 'feel-good local project'),
]
for suffix in ('.txt', '.vtt'):
    path = Path(stem + suffix)
    if not path.is_file():
        raise SystemExit(f'Missing: {path}')
    original = path.read_text(encoding='utf-8-sig')
    updated = original
    count = 0
    for pattern, replacement in fixes:
        updated, n = re.subn(pattern, replacement, updated, flags=re.IGNORECASE)
        count += n
    if suffix == '.vtt':
        timestamps = lambda s: re.findall(r'^\S+\s+-->\s+\S+.*$', s, re.MULTILINE)
        if timestamps(original) != timestamps(updated):
            raise RuntimeError('VTT timestamps changed; refusing to write')
    if updated != original:
        backup = Path(str(path) + '.bak')
        if not backup.exists():
            shutil.copy2(path, backup)
        path.write_text(updated, encoding='utf-8')
    print(f'{path.name}: {count} corrections')
PY

