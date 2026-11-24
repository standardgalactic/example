#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
python3 - <<'PY'
from pathlib import Path
import re, shutil
stem = 'The_Spherepop_Protocol_for_AI_Code_Maintenance'
fixes = [
    (r'\b(?:SpherePop|SpherePot|sphere pop|Sphere of Pop)\b', 'SpherePOP'),
    (r'\barchitectural invariance\b', 'architectural invariants'),
    (r'\bthe invariance\b', 'the invariants'),
    (r'\bunbreakable invariance\b', 'unbreakable invariants'),
    (r'\buniqueness in variant\b', 'uniqueness invariant'),
    (r'\bgrammar and variant\b', 'grammar invariant'),
    (r'\breviewing principle\b', 'reviewing principal'),
    (r'\bsigning keys of the principles\b', 'signing keys of the principals'),
    (r'\bspecific principle\b', 'specific principal'),
    (r'\buniversal scaler\b', 'universal scalar'),
    (r'\binto you, the unresolved bucket\b', 'into U, the unresolved bucket'),
    (r'\bthat you bucket\b', 'that U bucket'),
    (r'\bthe exactly same\b', 'the exact same'),
    (r'\bREST backend\b', 'Rust backend'),
    (r'\bto the REST,\b', 'to the Rust,'),
    (r'\bcode base\b', 'codebase'),
    (r'\btool chains\b', 'toolchains'),
]
# The second Rust reference ends in punctuation, so match before the comma.
fixes[14] = (r'\bto the REST,', 'to the Rust,')
paths = [Path(stem + ext) for ext in ('.txt', '.vtt')]
results = []
for path in paths:
    original = path.read_bytes()
    source = original.decode('utf-8')
    updated = source
    count = 0
    for pattern, replacement in fixes:
        def replace(m):
            global count
            if m.group() != replacement:
                count += 1
            return replacement
        updated = re.sub(pattern, replace, updated, flags=re.IGNORECASE)
    assert re.findall(r'\r\n|\r|\n', source) == re.findall(r'\r\n|\r|\n', updated)
    if path.suffix == '.vtt':
        assert [l for l in source.splitlines() if '-->' in l] == [l for l in updated.splitlines() if '-->' in l]
    results.append((path, original, updated.encode('utf-8'), count))
for path, original, updated, count in results:
    if original != updated:
        backup = Path(str(path) + '.bak')
        if not backup.exists():
            shutil.copy2(path, backup)
        path.write_bytes(updated)
    print(f'{path.name}: {count} corrections')
PY

