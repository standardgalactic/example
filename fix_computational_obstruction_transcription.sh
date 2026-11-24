#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
python3 - <<'PY'
from pathlib import Path
import re, shutil
stem = 'The_Geometry_of_Computational_Obstruction'
paths = [Path(stem + ext) for ext in ('.txt', '.vtt')]
rules = [
    (r'\b(?:Phloxon|Phylaxion)\b', 'Flyxion'),
    (r'\b(?:Fermé|Fermi)(?=\'s last theorem)', 'Fermat'),
    (r"\bArmin Hawkins'", "Armin Haken's"),
    (r'\bHocken\b', 'Haken'),
    (r'\b(?:Mechner|Meissner)\b', 'Meixner'),
    (r'\bBruchat-Titz\b', 'Bruhat–Tits'),
    (r'\bcat-zero\b', 'CAT(0)'),
    (r'\bCertificate Conditioned Tractability\b', 'Certificate-Conditioned Tractability'),
    (r'\bcrossing wire identity\b', 'crossing-wire identity'),
    (r'\bis nVP\b', 'is in VP'),
    (r'\bindirect root\b', 'indirect route'),
    (r'\bcheap hole\b', 'cheap whole'),
    (r'\bhard and characteristic two\b', 'hard in characteristic two'),
    (r'\bone entry from each row in each column\b', 'one entry from each row and each column'),
    (r'\bmassive billion gates circuits\b', 'massive billion-gate circuits'),
]
updates = []
for path in paths:
    raw = path.read_bytes()
    original = raw.decode('utf-8')
    lines = original.splitlines(keepends=True)
    count = 0
    for i, line in enumerate(lines):
        if '-->' in line or line.strip() == 'WEBVTT':
            continue
        for pattern, replacement in rules:
            line, n = re.subn(pattern, replacement, line, flags=re.IGNORECASE)
            count += n
        lines[i] = line
    result = ''.join(lines)
    assert len(result.splitlines()) == len(original.splitlines())
    assert [l for l in result.splitlines() if '-->' in l] == [l for l in original.splitlines() if '-->' in l]
    updates.append((path, raw, result.encode('utf-8'), count))
for path, raw, result, count in updates:
    if result != raw:
        backup = path.with_name(path.name + '.bak')
        if not backup.exists():
            shutil.copy2(path, backup)
        path.write_bytes(result)
    print(f'{path.name}: {count} matched corrections; {"updated" if result != raw else "unchanged"}')
PY

