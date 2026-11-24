#!/usr/bin/env bash
set -euo pipefail
python3 - "$@" <<'PY'
from pathlib import Path
import sys, re, shutil
base = Path(sys.argv[1]) if len(sys.argv)>1 else Path('.')
replacements = {
    'rending the privilege': 'renting the privilege',
    'Non-Compute': 'Non-Compete',
    'Fleissen': 'Flyxion',
    'Fleischian': 'Flyxion',
    'Flagshin': 'Flyxion',
    'Fleschian': 'Flyxion',
    'But one strip of health insurance': 'But one stripped of health insurance',
    'graphics, processing units, the power, everything': 'graphics processing units that power everything',
    'log out of their systems at 9 a.m.': 'log on to their systems at 9 a.m.',
    'authorization and dependence': 'authorization independence',
    'Which Lou calls virtue hoarding': 'Which Liu calls virtue hoarding',
    'personal fugality': 'personal frugality',
    'Q. Laura': 'QLoRA',
    'high bandwidth memory': 'high-bandwidth memory',
    'homebrew computer club': 'Homebrew Computer Club',
}
paths = [base / ('Are_You_Just_Renting_Your_Computer.' + ext) for ext in ('txt','vtt')]
for p in paths:
    if not p.is_file(): raise SystemExit(f'Missing file: {p}')
for p in paths:
    original = p.read_bytes().decode('utf-8')
    count = 0
    lines = original.splitlines(keepends=True)
    for i,line in enumerate(lines):
        if p.suffix == '.vtt' and ('-->' in line or line.strip() == 'WEBVTT'): continue
        for old,new in replacements.items():
            count += line.count(old)
            line = line.replace(old,new)
        lines[i] = line
    updated = ''.join(lines)
    if updated != original:
        backup = p.with_name(p.name + '.bak')
        if not backup.exists(): shutil.copy2(p, backup)
        p.write_bytes(updated.encode('utf-8'))
    print(f'{p.name}: {count} corrections')
PY

