#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
python3 - <<'PY'
from pathlib import Path
import re, shutil
stem = 'Why_AI_Language_Models_Aren_t_Authors'
fixes = [
 ('surfer farm', 'server farm'),
 ('been fine to be', 'been fine-tuned to be'),
 ('Richard Nisbet', 'Richard Nisbett'),
 ('difficult to bend down', 'difficult to pin down'),
 ('Enphylaxis adapts', 'And Flyxion adapts'),
 ('enterograde amnesia', 'anterograde amnesia'),
 ('Fleason', 'Flyxion'),
 ('Stakeless software', 'stateless software'),
 ('single contact state', 'single context state'),
 ('Rav Fogel', 'Ravfogel'),
 ('chat GPT', 'ChatGPT'),
 ('Mark Solmes', 'Mark Solms'),
 ('Carl Fristen', 'Karl Friston'),
 ('wall clock time', 'wall-clock time'),
 ('code base', 'codebase'),
]
for ext in ('.txt', '.vtt'):
    p = Path(stem + ext)
    original = p.read_bytes().decode('utf-8')
    updated = original
    total = 0
    for old, new in fixes:
        updated, n = re.subn(r'\b' + re.escape(old) + r'\b', lambda m: new, updated)
        if n:
            print(f'{p.name}: {old} -> {new} ({n})')
        total += n
    assert original.splitlines(keepends=True).__len__() == updated.splitlines(keepends=True).__len__()
    if ext == '.vtt':
        assert [l for l in original.splitlines() if '-->' in l] == [l for l in updated.splitlines() if '-->' in l]
    if updated != original:
        backup = p.with_name(p.name + '.bak')
        if not backup.exists(): shutil.copy2(p, backup)
        p.write_bytes(updated.encode('utf-8'))
    print(f'{p.name}: {total} corrections')
PY

